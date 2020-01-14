# 多工程联编Podfile文件配置
workspace 'AppWorkspace'      # 需要生成的workspace的名称
# project 'path' 指定包含Pods库应链接的目标的Xcode项目，其中path为项目链接的路径
# 对于1.0之前的版本，请使用xcodeproj后缀名
project 'HNWKit/HNWKit' 			# 套件库工程
project 'HNWMainProj/HNWMainProj'   # 主体工程

platform :ios, '8.0'
inhibit_all_warnings!   			# 禁止CocoaPods库中的所有警告。
def commonPods
    pod 'FMDB', '~> 2.7.5'
end

target 'HNWKit' do
    project 'HNWKit/HNWKit'
    commonPods
end

target 'HNWMainProj' do
    project 'HNWMainProj/HNWMainProj'
    commonPods
    pod 'AFNetworking', '~> 3.2.1'
    pod 'SDWebImage', '~> 5.4.2'
    pod 'MJRefresh', '~> 3.3.1'

    target 'HNWMainProjTests' do
    	project 'HNWMainProj/HNWMainProj'
    	inherit! :search_paths
  	end
end
