# 3D 重建技术
本项目聚焦于 3D 重建技术，核心内容包括 NeRF 的基本原理、优化与局限，其加速技术 TensoRF 的张量分解建模，以及 3D Gaussian Splatting 的场景表示与优化方法。本项目依托于Nerfstudio仓库的相关算法实现，并选择复旦大学CFFF的PAI灵骏智算平台作为实验平台，算力配置为16核cpu和一张A100，cuda版本为12.1。
## 数据集
<div align="left">
  <p>本项目所使用的数据集是由手机拍摄 177 张多角度的高清图片，下载链接为http://dsw-gateway.cfff.fudan.edu.cn:32080/dsw-21316/lab/tree/zl_dl/hw3/images 。</p>
  <img src="show data.png" alt="示意图" width="400">
</div>

## 仓库结构
```
├── data_processing.sh                  # 数据处理
├── train_3dgs.sh                       # 3D Gaussian Splatting 训练代码
├── train_nerf.sh                       # NeRF 训练代码
├── train_tensorf.sh                    # TensoRF 训练代码
├── render.sh                           # 渲染代码
├── README.md                           # 项目说明文件
├── colmap                              # colmap 处理结果
```
## 环境配置
根据`Nerfstudio`仓库的官方指南配置环境，仓库详见 https://github.com/nerfstudio-project/nerfstudio/ 。
## 数据预处理
先下载 http://dsw-gateway.cfff.fudan.edu.cn:32080/dsw-21316/lab/tree/zl_dl/hw3/images 中的数据集于当前文件夹，并命名为images，运行
```
bash data_processing.sh
```
即可生成processed_data文件夹，即为适配于训练的数据集结构。
## 模型训练
直接运行'train'开头的三个文件即可分别训练NeRF、TensoRF和3D Gaussian Splatting模型，训练好的参数放在 http://dsw-gateway.cfff.fudan.edu.cn:32080/dsw-21316/lab/tree/zl_dl/hw3/outputs 中。
## 渲染
修改`render.sh`中的路径为对应于训练的config.yml文件，运行`bash render.sh`即可渲染视频。当然也可以选择下载我们渲染好的视频 http://dsw-gateway.cfff.fudan.edu.cn:32080/dsw-21316/lab/tree/zl_dl/hw3/renders 。
## 3种模型的运行效率
| 方法                     | CPU 平均占用率 | GPU 平均占用率 | 训练时间 (s) | 渲染用时 (s) |
|--------------------------|----------------|----------------|--------------|---------------|
| NeRF                     | 12.20 %        | 84.50 %        | 3696.8       | 1520.1        |
| TensoRF                  | 16.10 %        | 35.60 %        | 2436.5       | 1637.5        |
| 3D Gaussian Splatting    | 12.70 %        | 47.90 %        | 794.1        | 33.1          |
