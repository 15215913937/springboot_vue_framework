package com.sqn.library.controller;

import com.sqn.library.common.Constants;
import com.sqn.library.common.Result;
import com.sqn.library.entity.Health;
import com.sqn.library.service.IHealthService;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author shenqn
 * @since 2023-02-23
 */
@RestController
@RequestMapping("/health")
public class HealthController {

    @Resource
    IHealthService healthService;
    @Resource
    StringRedisTemplate stringRedisTemplate;


    /**
     * 新增或者更新
     */
    @PostMapping("/save/{isSimple}")
    public Result<?> save(@RequestBody Health health, @PathVariable boolean isSimple) {
        if (health.getHeight() == null || health.getWeight() == null) {
            return Result.error(Constants.CODE_COMMON_ERR, "身高和体重都要填哦！");
        }
        if (isSimple && (health.getHeight() == 0 || health.getWeight() == 0)) {
            return Result.error(Constants.CODE_COMMON_ERR, "身高或体重输入错误");
        }
        boolean add = healthService.add(health);
        if (!add) {
            return Result.error(Constants.CODE_COMMON_ERR, "提交错误");
        }
        return Result.success();
    }

    @DeleteMapping("/{id}")
    public Result<?> delete(@PathVariable Long id) {
        healthService.removeById(id);
        return Result.success();
    }

    @PostMapping("/deleteBatch")
    public Result<?> deleteBatch(@RequestBody List<Integer> ids) {
        healthService.removeByIds(ids);
        return Result.success();
    }

    @GetMapping
    public Result<?> findAll() {
        return Result.success(healthService.list());
    }

    @PostMapping("/queryLatestInfo/{uid}")
    public Result<?> queryLatestInfo(@PathVariable Long uid) {
        List<Health> list = healthService.getByUid(uid);
        return Result.success(list);
    }

    @GetMapping("/{id}")
    public Result<?> findOne(@PathVariable Long id) {
        return Result.success(healthService.getById(id));
    }

    @GetMapping("/findHistoryActivities/{uid}")
    public Result<?> findHistoryActivities(@PathVariable Long uid) {
        return Result.success(healthService.queryHistoryActivities(uid));
    }
}
