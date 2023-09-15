platform :ios, '13.0'

target 'Cafeteria St Paul' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Cafeteria St Paul
    pod 'Firebase/Auth'
    pod 'Firebase/Firestore'
  #  pod 'Firebase/Analytics'
  #  pod 'Firebase/Crashlytics'
    pod 'IQKeyboardManagerSwift'
    pod 'Kingfisher', '7.6.1'
    pod 'ProgressHUD'


end


post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end
