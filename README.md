- 类型

  > 地图服务
  
- 时间

  > 2020年11月至2020年12月

- 项目简介

  > 活动断层采集子系统是给中国国家地震局做的一款内部使用的APP，用于帮助外部作业人员采集活动断层的信息并上传到服务器。项目采用了ArcGIS和天地图来作为地图服务，因为考虑到采集地可能在山区，无网络环境下使用了sqlite进行数据存储。

- 技术点

  > 1、ArcGIS SDK加载天地图瓦片图层
  > 2、使用ArcGIS在图层上进行绘图
  > 3、使用RSA加密登陆

- 架构

  > 1、语言：Objective-C
  > 2、网络请求：[AFNetworking](https://github.com/AFNetworking/AFNetworking)
  > 3、UI:Storyboard + [BDToolKit](https://github.com/reference/BDToolKit) + [ZXToolbox](https://github.com/xinyzhao/ZXToolbox)
  > 4、数据库：sqlite + [BGFMDB](https://github.com/huangzhibiao/BGFMDB)
  > 5、地图服务：[ArcGIS SDK](https://developers.arcgis.com/) + [天地图图层](https://www.tianditu.gov.cn/)
  > 6、其他：YYKit SDWebImage IQKeyboardManager MJRefresh SVProgressHUD Reachability等

- 项目截图

  > | <img src="https://img.wenhairu.com/images/2020/12/11/Wtwr0.png" width="200"/> | <img src="https://img.wenhairu.com/images/2020/12/11/Wtluf.png" width="200"/> |
  > | :----------------------------------------------------------: | :----------------------------------------------------------: |
  > |                             首页                             |                        ArcGIS+天地图                         |

- 分发上线
	
	> 企业级分发

- 开发人员

  > IOS © [班殿宏](https://scottban.live)
  > Android © [王超](https://blog.csdn.net/weixin_43966262?spm=1001.2101.3001.5113)

- 公司

  > © *中国软件与技术服务股份有限公司*
