Pod::Spec.new do |s|
# 框架名称
s.name = 'JXLib'
# 版本号
s.version = '0.0.1'
# 描述信息
s.summary = 'desc'
# 主页，填百度应该也可以吧
s.homepage = 'https://github.com/MrChen123/JXLib'
# 作者信息
s.authors = { 'William' => 'XXX@qq.com' }
# 看你放在哪里了，我这边就直接填本地了
s.source = { :git => '/Users/xinhuikeji/Desktop/JiangXiResource 2', :tag => '0.0.1' }
# arc
s.requires_arc = true
# license
s.license = 'MIT'
# iOS版本
s.ios.deployment_target = '7.0'
# 自定义项目存放的路径
s.source_files = 'JiangXiResource/Common/*.{h,m}','JiangXiResource/Controllers/**/*.{h,m}','JiangXiResource/Utils/**/*.{h,m}'
# 图片，其他资源文件存放的路径，需要注意的是，xib，nib也属于资源文件
s.resource = 'JiangXiResource/Utils/STTextHud/*'
# 如果你的库使用了其他第三方库，需要加入
s.dependency  'JSONModel'
s.dependency  'Masonry'
s.dependency  'MJRefresh'
s.dependency  'YTKNetwork'
s.dependency  'MBProgressHUD'
end