# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'LalaChallenge' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for LalaChallenge
  pod 'Alamofire',              '4.8.2'
  pod 'AlamofireObjectMapper',  '5.2.0'
  pod 'RxSwift',                '5.1.0'
  pod 'RxCocoa',                '5.1.0'
  pod 'RxDataSources',          '4.0.1'
  pod 'ObjectMapper',           '3.4.2'
  pod 'SDWebImage',             '4.4.3'
  pod 'RealmSwift',             '3.19.1'
  pod 'JGProgressHUD',          '2.1'
  
  pod 'UIScrollView-InfiniteScroll', '1.1.0'

  # Specify specific Swift Version per dependency
  post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
            config.build_settings['APPLICATION_EXTENSION_API_ONLY'] = 'No'
        end
    end
  end
end
