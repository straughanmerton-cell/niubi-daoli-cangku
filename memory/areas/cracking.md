# 🔨 破解技术

## 核心原则
1. **改跳转永远比逆向算法快10倍** - 不需要完美理解，只需要绕过
2. **x64dbg + Ghidra是黄金组合** - 动态找关键点，静态看伪代码
3. **dnSpy处理.NET最简单** - 跟看源码一样改C#

## 常用命令速查
```bash
# 通用查壳
detect-it-easy target.exe

# UPX脱壳
upx -d target.exe

# 资源修改
Resource Hacker 打开 → 改字串/图标/菜单
```

## 相关经验（patterns.json）
- crack-software-patch
- crack-keygen
- crack-packing-unpacking
- crack-resource-hack
- crack-license-bypass
- binary-patch-imhex
- software-clone-1to1

## 关键工具
x64dbg(48.7k⭐) / Ghidra / dnSpy(29.5k⭐) / ImHex(54k⭐) / Cheat Engine(18.5k⭐)
