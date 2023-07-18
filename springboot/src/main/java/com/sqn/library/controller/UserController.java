package com.sqn.library.controller;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.bean.copier.CopyOptions;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.dto.LoginDTO;
import com.sqn.library.controller.dto.UserListDTO;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.entity.Menu;
import com.sqn.library.entity.Role;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.mapper.UserMapper;
import com.sqn.library.service.IMenuService;
import com.sqn.library.service.IRoleService;
import com.sqn.library.service.IUserService;
import com.sqn.library.utils.RedisUtils;
import com.sqn.library.utils.SecurityUtils;
import com.sqn.library.utils.TokenUtils;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * Rest模式
 *
 * @author sqn
 */
@Validated
@RestController
@RequestMapping("/user")
@Api(tags = {"成员管理"})
@Slf4j
public class UserController {
    @Resource
    UserMapper userMapper;

    @Resource
    IUserService iUserService;

    @Resource
    IRoleService iRoleService;

    @Resource
    IMenuService iMenuService;

    @Resource
    RedisUtils redisUtils;


    /**
     * 登录接口
     *
     * @param loginDTO
     * @return
     */
    @PostMapping("/login")
    public Result<?> login(@RequestBody LoginDTO loginDTO) {
        User user = new User();
        if (StrUtil.isNotBlank(loginDTO.getUsername())) {
            user = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, loginDTO.getUsername()));
            if (user == null || !SecurityUtils.matchesPassword(loginDTO.getPassword(), user.getPassword())) {
                return Result.error(Constants.CODE_COMMON_ERR, "用户名或密码错误！");
            }
            if (user.getIsDelete() == 1) {
                return Result.error(Constants.CODE_COMMON_ERR, "账户已冻结，请联系管理员");
            }
        } else if (StrUtil.isNotBlank(loginDTO.getPhone())) {
            String cacheCode = redisUtils.get(Constants.LOGIN_CODE_KEY);
            if (!loginDTO.getCode().equals(cacheCode)) {
                return Result.error(Constants.CODE_COMMON_ERR, "验证码错误");
            }

            redisUtils.delete(Constants.LOGIN_CODE_KEY);
            User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getPhone, loginDTO.getPhone()));
            if (res == null) {
                user.setRole(Constants.ROLE_VISITOR);
                user.setUsername(Constants.PREFIX_USERNAME + RandomUtil.randomString(8));
                user.setPassword(SecurityUtils.encodePassword(Constants.DEFAULT_PASSWORD));
                user.setName(Constants.PREFIX_NAME + RandomUtil.randomString(8));
                user.setPhone(loginDTO.getPhone());
                userMapper.insert(user);
                user = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getPhone,
                        loginDTO.getPhone()));
            } else if (res.getIsDelete() == 1) {
                return Result.error(Constants.CODE_COMMON_ERR, "账户已冻结，请联系管理员");
            } else {
                user = res;
            }
        }
        Role one = iRoleService.getOne(Wrappers.<Role>lambdaQuery().eq(Role::getFlag, user.getRole()));
        ArrayList<Menu> roleMenus = iMenuService.findRoleMenus(one.getId());
        user.setMenus(roleMenus);
        // 生成token
        String token = TokenUtils.getToken(user);
        user.setToken(token);
        // 更新登录时间
        iUserService.updateRecentLoginTime(user.getId());
        iUserService.setStatusOnline(user.getId());
        // Map<String, Object> beanToMap(Object bean, boolean isToUnderlineCase, boolean ignoreNullValue)
        // 功能：将一个对象转换成Map<String, Object>，属性名为key，值为value，只支持实例变量。
        // 参数解释：bean待转对象，isToUnderlineCase是否转下划线，ignoreNullValue是否忽略空值。
        // setFieldValueEditor编辑键值对，使用箭头函数，例：（键，值）->值类型转字符串
        Map<String, Object> stringObjectMap = BeanUtil.beanToMap(user, new HashMap<>(),
                CopyOptions.create().setIgnoreNullValue(true).setFieldValueEditor((fieldName, fieldValue) -> {
                    if (fieldValue == null) {
                        fieldValue = "0";
                    } else {
                        fieldValue = fieldValue + "";
                    }
                    return fieldValue;
                }));
        String key = Constants.USER_KEY + user.getId();
        redisUtils.hPutAllEx(key, stringObjectMap, Constants.LOGIN_INFO_TTL, TimeUnit.HOURS);
        return Result.success(user);
    }

    /**
     * 发送手机验证码
     *
     * @param phone
     * @return
     */
    @GetMapping("/sendCode")
    public Result<?> sendCode(@RequestParam String phone) {
        Boolean isSend = iUserService.sendCode(phone);
        if (Boolean.FALSE.equals(isSend)) {
            return Result.error(Constants.CODE_COMMON_ERR, "手机号格式错误");
        }
        return Result.success();
    }

    /**
     * 修改密码
     *
     * @return
     */
    @PostMapping("/updatePwd")
    public Result<?> updatePwd(@RequestBody UserPasswordDTO userPasswordDTO) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<User>();
        queryWrapper.eq(User::getUsername, userPasswordDTO.getUsername());
        User res = userMapper.selectOne(queryWrapper);
        if (!SecurityUtils.matchesPassword(userPasswordDTO.getPassword(), res.getPassword())) {
            return Result.error(Constants.CODE_COMMON_ERR, "原密码错误");
        }
        // 把前端传过来的新密码加密处理
        userPasswordDTO.setNewPassword(SecurityUtils.encodePassword(userPasswordDTO.getNewPassword()));
        iUserService.updatePassword(userPasswordDTO);
        return Result.success();
    }

    /**
     * 重置密码
     *
     * @param userResetPwdDTO
     * @return
     */
    @PostMapping("/resetPwd")
    public Result<?> resetPwd(@RequestBody UserResetPwdDTO userResetPwdDTO) {
        if (userResetPwdDTO.getNewPassword() == null) {
            userResetPwdDTO.setNewPassword(SecurityUtils.encodePassword(Constants.DEFAULT_PASSWORD));
        } else {
            //把前端传过来的新密码加密处理
            userResetPwdDTO.setNewPassword(SecurityUtils.encodePassword(userResetPwdDTO.getNewPassword()));
        }
        iUserService.resetPwd(userResetPwdDTO);
        return Result.success();
    }

    /**
     * 注册接口
     *
     * @param user
     * @return
     * @throws Exception
     */
    @PostMapping("/register")
    public Result<?> register(@RequestBody User user) throws Exception {
        try {
            User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
            if (res != null) {
                return Result.error(Constants.CODE_COMMON_ERR, "用户名已存在");
            }
            user.setRole(Constants.ROLE_VISITOR);
            user.setName(user.getUsername());
            user.setPassword(SecurityUtils.encodePassword(user.getPassword()));
            userMapper.insert(user);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error(Constants.CODE_INTERNAL_ERR, "登录异常");
        }
        return Result.success();
    }


    /**
     * 新增或更新接口
     *
     * @param user
     * @return
     */
    @PostMapping
    public Result<?> save(@Valid @RequestBody User user) {
        User one = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        if ((one != null && user.getId() == null) || (one != null && !one.getId().equals(user.getId()))) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "该用户已存在");
        }
        if (StrUtil.isBlank(user.getUsername())) {
            throw new CustomException(Constants.CODE_COMMON_ERR, "用户名未填写");
        }
        if (user.getPassword() == null) {
            user.setPassword(SecurityUtils.encodePassword("123456"));
        }
        if (user.getRole() == null) {
            user.setRole(Constants.ROLE_VISITOR);
        }
        if (user.getName() == null) {
            user.setName(user.getUsername());
        }
        iUserService.saveOrUpdate(user);
        redisUtils.delete(Constants.USER_KEY);
        return Result.success();

    }

    /**
     * 用户删除
     *
     * @param id
     * @return
     */
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        iUserService.isDeleteById(id);
        return Result.success();
    }

    /**
     * 分页查询接口
     *
     * @param pageNum
     * @param pageSize
     * @param name
     * @param role
     * @return
     */
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String role) {
        Page<User> userPage = userMapper.findPage(new Page<>(pageNum, pageSize), name, role);
        return Result.success(userPage);
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Long id) {
        User user = iUserService.getById(id);
        return Result.success(user);
    }


    @GetMapping("/all")
    public Result<?> findAll() {
        ArrayList<UserListDTO> userAll = userMapper.getName();
        return Result.success(userAll);
    }

}
