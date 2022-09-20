package com.sqn.library.controller;

import cn.hutool.core.lang.TypeReference;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.controller.dto.LoginByPhoneDTO;
import com.sqn.library.controller.dto.UserPasswordDTO;
import com.sqn.library.controller.dto.UserResetPwdDTO;
import com.sqn.library.controller.dto.UserSearchDTO;
import com.sqn.library.entity.Menu;
import com.sqn.library.entity.User;
import com.sqn.library.exception.CustomException;
import com.sqn.library.exception.GlobalExceptionHandler;
import com.sqn.library.mapper.*;
import com.sqn.library.service.IMenuService;
import com.sqn.library.service.IUserService;
import com.sqn.library.utils.RedisUtils;
import com.sqn.library.utils.SecurityUtils;
import com.sqn.library.utils.TokenUtils;
import io.swagger.annotations.Api;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.security.cert.CertStoreException;
import java.util.ArrayList;
import java.util.List;

import static com.sqn.library.common.Constants.USER_KEY;

/**
 * Rest模式
 */
@Validated
@RestController
@RequestMapping("/user")
@Api(tags = {"成员管理"})
public class UserController {
    @Resource
    UserMapper userMapper;

    @Resource
    IUserService iUserService;

    @Resource
    RoleMapper roleMapper;

    @Resource
    RoleMenuMapper roleMenuMapper;

    @Resource
    IMenuService iMenuService;

    @Resource
    MenuMapper menuMapper;


    @Resource
    RedisUtils redisUtils;

    //登录接口
    //@RequestBody ：把前端传过来的json对象转换为java对象
    @PostMapping("/login")
    public Result<?> login(@RequestBody User user) {
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        if (res == null || !SecurityUtils.matchesPassword(user.getPassword(), res.getPassword())) {
            return Result.error(Constants.CODE_COMMON_ERR, "用户名或密码错误！");
        }
        Integer roleId = roleMapper.selectByFlag(res.getRole());
        //当前角色的所有菜单id集合
        List<Integer> menuIds = roleMenuMapper.selectByRoleId(roleId);
        //查出系统所有菜单
        List<Menu> menus = iMenuService.findMenus("");
        //new一个最后筛选后的list
        List<Menu> roleMenus = new ArrayList<>();
        //筛选当前用户角色的菜单
        for (Menu menu : menus) {
//            获取每个父菜单的子菜单
            List<Menu> children = menu.getChildren();
            if (menuIds.contains(menu.getId()) || (!menuIds.contains(menu.getId()) && children.size() != 0)) {
                roleMenus.add(menu);
            }
            //移除children里面不在menuIds集中的元素
            children.removeIf(child -> !menuIds.contains(child.getId()));
        }

        res.setMenus(roleMenus);
        // 生成token
        String token = TokenUtils.genToken(res);
        res.setToken(token);
//        flushRedis(USER_KEY);
        return Result.success(res);
    }

    //手机号登录或注册
    @PostMapping("/loginByPhone")
    public Result<?> loginByPhone(@RequestBody LoginByPhoneDTO loginByPhoneDTO) {
        User user = new User();
        User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getPhone, loginByPhoneDTO.getPhone()));
        if (res == null) {
            user.setRole("ROLE_VISITOR");
            user.setUsername("qnShen_" + RandomUtil.randomString(8));
            user.setPassword(SecurityUtils.encodePassword("123456"));
            user.setName("游客_" + RandomUtil.randomString(8));
            user.setPhone(loginByPhoneDTO.getPhone());
            userMapper.insert(user);
            user = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getPhone,
                    loginByPhoneDTO.getPhone()));
        } else {
            user = res;
        }

        Integer roleId = roleMapper.selectByFlag(user.getRole());
        //当前角色的所有菜单id集合
        List<Integer> menuIds = roleMenuMapper.selectByRoleId(roleId);
        //查出系统所有菜单
        List<Menu> menus = iMenuService.findMenus("");
        //new一个最后筛选后的list
        List<Menu> roleMenus = new ArrayList<>();
        //筛选当前用户角色的菜单
        for (Menu menu : menus) {
//            获取每个父菜单的子菜单
            List<Menu> children = menu.getChildren();
            if (menuIds.contains(menu.getId()) || (!menuIds.contains(menu.getId()) && children.size() != 0)) {
                roleMenus.add(menu);
            }
            //移除children里面不在menuIds集中的元素
            children.removeIf(child -> !menuIds.contains(child.getId()));
        }
        user.setMenus(roleMenus);
        // 生成token
        String token = TokenUtils.genToken(user);
        user.setToken(token);
        return Result.success(user);
    }

    //    发送手机验证码
    @PostMapping("/code")
    public Result<?> sendCode(@RequestBody String phone, HttpSession session) {
        return iUserService.sendCode(phone, session);
    }

    /**
     * 修改密码
     *
     * @return
     * @throws Exception
     */
    @PostMapping("/updatePwd")
    public Result<?> updatePwd(@RequestBody UserPasswordDTO userPasswordDTO) {
        LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<User>();
        queryWrapper.eq(User::getUsername, userPasswordDTO.getUsername());
        User res = userMapper.selectOne(queryWrapper);
        if (!SecurityUtils.matchesPassword(userPasswordDTO.getPassword(), res.getPassword())) {
            return Result.error(Constants.CODE_COMMON_ERR, "原密码错误");
        }
        //把前端传过来的新密码加密处理
        userPasswordDTO.setNewPassword(SecurityUtils.encodePassword(userPasswordDTO.getNewPassword()));
        iUserService.updatePassword(userPasswordDTO);
        return Result.success();
    }

    //重置密码
    @PostMapping("/resetPwd")
    public Result<?> resetPwd(@RequestBody UserResetPwdDTO userResetPwdDTO) {
        if (userResetPwdDTO.getNewPassword() == null) {
            userResetPwdDTO.setNewPassword(SecurityUtils.encodePassword("123456"));
        } else {
            //把前端传过来的新密码加密处理
            userResetPwdDTO.setNewPassword(SecurityUtils.encodePassword(userResetPwdDTO.getNewPassword()));
        }
        iUserService.resetPwd(userResetPwdDTO);
        return Result.success();
    }

    //注册接口
    @PostMapping("/register")
    public Result<?> register(@RequestBody User user) throws Exception {
        try {
            User res = userMapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
            if (res != null) {
                return Result.error(Constants.CODE_COMMON_ERR, "用户名已存在");
            }
            user.setRole("ROLE_VISITOR");
            user.setName(user.getUsername());
            user.setPassword(SecurityUtils.encodePassword(user.getPassword()));
            userMapper.insert(user);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error(Constants.CODE_INTERNAL_ERR, "登录异常");
        }
        return Result.success();
    }


    //新增或更新接口
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
            user.setRole("ROLE_VISITOR");
        }
        if (user.getName() == null) {
            user.setName(user.getUsername());
        }
        iUserService.saveOrUpdate(user);
//        redisUtils.flushRedis(USER_KEY);
        return Result.success();

    }

    //删除接口
    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        iUserService.removeById(id);
//        redisUtils.flushRedis(USER_KEY);
        return Result.success();
    }

    //分页查询接口
    @GetMapping
    public Result<?> findPage(@RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "10") Integer pageSize,
                              @RequestParam(defaultValue = "") String name,
                              @RequestParam(defaultValue = "") String role) {
        Page<User> userPage = userMapper.findPage(new Page<>(pageNum, pageSize), name, role);
        return Result.success(userPage);
    }


    @GetMapping("/{id}")
    public Result<?> getById(@PathVariable Integer id) {
//        设置缓存
//        String s =
//        User user;
//        if (StrUtil.isBlank(s)) {
//            user = userMapper.selectById(id);
//            stringRedisTemplate.opsForValue().set(USER_KEY, JSONUtil.toJsonStr(user));
//        } else {
//            user = JSONUtil.toBean(s, new TypeReference<User>() {
//            }, true);
//        }
        return Result.success(userMapper.selectById(id));

    }


    @GetMapping("/all")
    public Result<?> findAll() {
        return Result.success(iUserService.list());
    }

}
