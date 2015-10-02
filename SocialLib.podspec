#
# Be sure to run `pod lib lint SocialLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SocialLib"
  s.version          = "0.0.2"
  s.summary          = "SocialLib handles sharing message to multiple social media."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
SocialLib handles sharing message to multiple social media.
Now support twitter, facebook, tumblr, wechat (weixin) and weibo.
                       DESC

  s.homepage         = "https://github.com/darkcl/SocialLib"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Yeung Yiu Hung" => "hkclex@gmail.com" }
  s.source           = { :git => "https://github.com/darkcl/SocialLib.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true
  # s.source_files = 'Pod/Classes/**/*'
  # s.resource_bundles = {
  #   'SocialLib' => ['Pod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.frameworks = 'Accounts', 'ImageIO', 'SystemConfiguration', 'CoreText', 'QuartzCore', 'Security', 'UIKit', 'Foundation', 'CoreGraphics','CoreTelephony', 'SystemConfiguration', 'MobileCoreServices'

  s.libraries = 'c++', 'z', 'sqlite3', 'icucore'
  # s.dependency 'AFOAuth1Client'
  # s.dependency 'FBSDKCoreKit'
  # s.dependency 'FBSDKLoginKit'
  # s.dependency 'FBSDKShareKit'
  # s.dependency 'STTwitter'
  # s.dependency 'WeiboSDK'
  # s.dependency 'Weixin'

  s.subspec 'Core' do |core|
    core.source_files  = 'Pod/Classes/Core/*.{h,m}'
  end

  s.subspec 'Facebook' do |facebook|
    facebook.source_files  = 'Pod/Classes/Facebook/*.{h,m}'
    facebook.dependency 'SocialLib/Core'
    facebook.dependency 'FBSDKCoreKit'
    facebook.dependency 'FBSDKLoginKit'
    facebook.dependency 'FBSDKShareKit'
  end

  s.subspec 'Twitter' do |twitter|
    twitter.source_files = 'Pod/Classes/Twitter/*.{h,m}'
    twitter.dependency 'SocialLib/Core'
    twitter.dependency 'STTwitter'
  end

  s.subspec 'Tumblr' do |tumblr|
    tumblr.source_files = 'Pod/Classes/Tumblr/*.{h,m}'
    tumblr.dependency 'SocialLib/Core'
    tumblr.dependency 'AFOAuth1Client'
  end

  s.subspec 'Weibo' do |weibo|
    weibo.source_files = 'Pod/Classes/Weibo/*.{h,m}'
    weibo.dependency 'SocialLib/Core'
    weibo.dependency 'WeiboSDK'
  end

  s.subspec 'Weixin' do |weixin|
    weixin.source_files = 'Pod/Classes/Weixin/*.{h,m}'
    weixin.dependency 'SocialLib/Core'
    weixin.dependency 'Weixin'
  end

  s.subspec 'Instagram' do |instagram|
    instagram.source_files = 'Pod/Classes/Instagram/*.{h,m}'
    instagram.dependency 'SocialLib/Core'
  end
  s.default_subspecs = 'Core', 'Facebook', 'Twitter', 'Tumblr', 'Weibo', 'Weixin', 'Instagram'
end
