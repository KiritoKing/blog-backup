---
title: React & Typecript & Webpack 构建基础
date: 2022/10/22
---

## 工程构建

如何使用 webpack 配置 react

1. `npx webpack init` 来使用向导自动创建 `webpack.config.js`

   - 注意需要安装`webpack-cli`和`@webpack/generators`
   - 根据向导一路生成配置文件即可

2. 安装react相关模块

   - `npm i react & react-dom`
   - `npm i -D @types/react & @types/react-dom `

3. 修改`tsconfig.json`

   ```
   jsx: react
   lib: esnext, dom
   files: src/index.tsx
   ```

4. 安装ESLint（需要VSCode相关插件支持）

   1. `npm i eslint -g --save-dev`
   2. `eslint --init`：根据向导创建eslint配置文件

5. 安装Prettier（需要VSCode相关插件支持）

   - `npm i eslint-config-prettier -D `
   - 自己创建Prettier配置文件
   - 修改ESLint配置文件，添加`extends: prettier`


6. 修改webpack配置入口为`index.tsx`



## React Hooks

- `useMemo`用于性能优化，缓存数据
  - memorized的简称
  - 若被缓存的数据没有改变，刷新时（其他数据改变引起的刷新）会调用缓存而不会重新运算
- `useCallback`也用于性能优化，缓存函数
- 

