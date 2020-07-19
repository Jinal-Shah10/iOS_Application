# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DemoApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
	
	pod 'Alamofire', '~> 4.0'
	# pod 'MBProgressHUD'
	pod 'PromiseKit', '~> 4.0'
	# pod 'MBAutoGrowingTextView', '~> 0.1.0'
	# pod 'PusherSwift', '~> 3.0'
	# pod 'Bugsnag'
	# pod 'AutoCompleteTextField'
	pod 'Fabric'
	pod 'Crashlytics'
	pod 'SVProgressHUD'
	pod 'ALLoadingView'
	# pod 'IQKeyboardManagerSwift'
	pod 'ReachabilitySwift'
	pod 'RaisePlaceholder'
	pod 'PasswordTextField'
	# pod 'AJMessage'
	pod 'EMAlertController'
	# pod 'NotificationBannerSwift', '2.0.1'
	# pod 'YONAutoComplete'
	pod 'SwiftyNotifications', '~>0.5.3'
	pod 'SwiftyPickerPopover'
	
	

  # Pods for DemoApp

  target 'DemoAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'DemoAppUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '4.2'
		end
	end
end
