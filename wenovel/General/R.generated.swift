//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 color palettes.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 0 files.
  struct file {
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 0 fonts.
  struct font {
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 43 images.
  struct image {
    /// Image `btn_gray_round_border_bg`.
    static let btn_gray_round_border_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "btn_gray_round_border_bg")
    /// Image `control_mask_view`.
    static let control_mask_view = Rswift.ImageResource(bundle: R.hostingBundle, name: "control_mask_view")
    /// Image `icon_add`.
    static let icon_add = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_add")
    /// Image `icon_arrow_down`.
    static let icon_arrow_down = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_arrow_down")
    /// Image `icon_arrow_left`.
    static let icon_arrow_left = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_arrow_left")
    /// Image `icon_arrow_right`.
    static let icon_arrow_right = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_arrow_right")
    /// Image `icon_arrow_up`.
    static let icon_arrow_up = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_arrow_up")
    /// Image `icon_calendar`.
    static let icon_calendar = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_calendar")
    /// Image `icon_close`.
    static let icon_close = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_close")
    /// Image `icon_comment`.
    static let icon_comment = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_comment")
    /// Image `icon_commit`.
    static let icon_commit = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_commit")
    /// Image `icon_delete`.
    static let icon_delete = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_delete")
    /// Image `icon_downlooad`.
    static let icon_downlooad = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_downlooad")
    /// Image `icon_edit`.
    static let icon_edit = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_edit")
    /// Image `icon_facebook`.
    static let icon_facebook = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_facebook")
    /// Image `icon_file`.
    static let icon_file = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_file")
    /// Image `icon_filter`.
    static let icon_filter = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_filter")
    /// Image `icon_folder`.
    static let icon_folder = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_folder")
    /// Image `icon_full_screen`.
    static let icon_full_screen = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_full_screen")
    /// Image `icon_like`.
    static let icon_like = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_like")
    /// Image `icon_link`.
    static let icon_link = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_link")
    /// Image `icon_lock`.
    static let icon_lock = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_lock")
    /// Image `icon_logout`.
    static let icon_logout = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_logout")
    /// Image `icon_message`.
    static let icon_message = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_message")
    /// Image `icon_more`.
    static let icon_more = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_more")
    /// Image `icon_printer`.
    static let icon_printer = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_printer")
    /// Image `icon_refresh`.
    static let icon_refresh = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_refresh")
    /// Image `icon_resize_ horizontal`.
    static let icon_resize_Horizontal = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_resize_ horizontal")
    /// Image `icon_resize_vertical`.
    static let icon_resize_vertical = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_resize_vertical")
    /// Image `icon_search`.
    static let icon_search = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_search")
    /// Image `icon_setting`.
    static let icon_setting = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_setting")
    /// Image `icon_share`.
    static let icon_share = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_share")
    /// Image `icon_to`.
    static let icon_to = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_to")
    /// Image `icon_user`.
    static let icon_user = Rswift.ImageResource(bundle: R.hostingBundle, name: "icon_user")
    /// Image `login_btn_facebook_bg`.
    static let login_btn_facebook_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_btn_facebook_bg")
    /// Image `login_btn_phone_bg`.
    static let login_btn_phone_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_btn_phone_bg")
    /// Image `login_btn_weibo_bg`.
    static let login_btn_weibo_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_btn_weibo_bg")
    /// Image `login_logo`.
    static let login_logo = Rswift.ImageResource(bundle: R.hostingBundle, name: "login_logo")
    /// Image `nav_shadow_background`.
    static let nav_shadow_background = Rswift.ImageResource(bundle: R.hostingBundle, name: "nav_shadow_background")
    /// Image `resize_button`.
    static let resize_button = Rswift.ImageResource(bundle: R.hostingBundle, name: "resize_button")
    /// Image `text_avatar`.
    static let text_avatar = Rswift.ImageResource(bundle: R.hostingBundle, name: "text_avatar")
    /// Image `text_weNovel`.
    static let text_weNovel = Rswift.ImageResource(bundle: R.hostingBundle, name: "text_weNovel")
    /// Image `tool_bar_bg`.
    static let tool_bar_bg = Rswift.ImageResource(bundle: R.hostingBundle, name: "tool_bar_bg")
    
    /// `UIImage(named: "btn_gray_round_border_bg", bundle: ..., traitCollection: ...)`
    static func btn_gray_round_border_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.btn_gray_round_border_bg, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "control_mask_view", bundle: ..., traitCollection: ...)`
    static func control_mask_view(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.control_mask_view, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_add", bundle: ..., traitCollection: ...)`
    static func icon_add(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_add, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_arrow_down", bundle: ..., traitCollection: ...)`
    static func icon_arrow_down(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_arrow_down, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_arrow_left", bundle: ..., traitCollection: ...)`
    static func icon_arrow_left(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_arrow_left, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_arrow_right", bundle: ..., traitCollection: ...)`
    static func icon_arrow_right(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_arrow_right, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_arrow_up", bundle: ..., traitCollection: ...)`
    static func icon_arrow_up(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_arrow_up, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_calendar", bundle: ..., traitCollection: ...)`
    static func icon_calendar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_calendar, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_close", bundle: ..., traitCollection: ...)`
    static func icon_close(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_close, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_comment", bundle: ..., traitCollection: ...)`
    static func icon_comment(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_comment, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_commit", bundle: ..., traitCollection: ...)`
    static func icon_commit(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_commit, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_delete", bundle: ..., traitCollection: ...)`
    static func icon_delete(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_delete, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_downlooad", bundle: ..., traitCollection: ...)`
    static func icon_downlooad(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_downlooad, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_edit", bundle: ..., traitCollection: ...)`
    static func icon_edit(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_edit, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_facebook", bundle: ..., traitCollection: ...)`
    static func icon_facebook(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_facebook, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_file", bundle: ..., traitCollection: ...)`
    static func icon_file(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_file, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_filter", bundle: ..., traitCollection: ...)`
    static func icon_filter(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_filter, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_folder", bundle: ..., traitCollection: ...)`
    static func icon_folder(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_folder, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_full_screen", bundle: ..., traitCollection: ...)`
    static func icon_full_screen(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_full_screen, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_like", bundle: ..., traitCollection: ...)`
    static func icon_like(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_like, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_link", bundle: ..., traitCollection: ...)`
    static func icon_link(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_link, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_lock", bundle: ..., traitCollection: ...)`
    static func icon_lock(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_lock, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_logout", bundle: ..., traitCollection: ...)`
    static func icon_logout(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_logout, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_message", bundle: ..., traitCollection: ...)`
    static func icon_message(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_message, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_more", bundle: ..., traitCollection: ...)`
    static func icon_more(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_more, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_printer", bundle: ..., traitCollection: ...)`
    static func icon_printer(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_printer, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_refresh", bundle: ..., traitCollection: ...)`
    static func icon_refresh(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_refresh, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_resize_ horizontal", bundle: ..., traitCollection: ...)`
    static func icon_resize_Horizontal(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_resize_Horizontal, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_resize_vertical", bundle: ..., traitCollection: ...)`
    static func icon_resize_vertical(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_resize_vertical, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_search", bundle: ..., traitCollection: ...)`
    static func icon_search(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_search, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_setting", bundle: ..., traitCollection: ...)`
    static func icon_setting(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_setting, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_share", bundle: ..., traitCollection: ...)`
    static func icon_share(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_share, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_to", bundle: ..., traitCollection: ...)`
    static func icon_to(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_to, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "icon_user", bundle: ..., traitCollection: ...)`
    static func icon_user(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.icon_user, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "login_btn_facebook_bg", bundle: ..., traitCollection: ...)`
    static func login_btn_facebook_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_btn_facebook_bg, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "login_btn_phone_bg", bundle: ..., traitCollection: ...)`
    static func login_btn_phone_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_btn_phone_bg, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "login_btn_weibo_bg", bundle: ..., traitCollection: ...)`
    static func login_btn_weibo_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_btn_weibo_bg, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "login_logo", bundle: ..., traitCollection: ...)`
    static func login_logo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.login_logo, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "nav_shadow_background", bundle: ..., traitCollection: ...)`
    static func nav_shadow_background(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.nav_shadow_background, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "resize_button", bundle: ..., traitCollection: ...)`
    static func resize_button(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.resize_button, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "text_avatar", bundle: ..., traitCollection: ...)`
    static func text_avatar(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.text_avatar, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "text_weNovel", bundle: ..., traitCollection: ...)`
    static func text_weNovel(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.text_weNovel, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "tool_bar_bg", bundle: ..., traitCollection: ...)`
    static func tool_bar_bg(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tool_bar_bg, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 3 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `SettingSignOutTableViewCell`.
    static let settingSignOutTableViewCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "SettingSignOutTableViewCell")
    /// Reuse identifier `UserInfoPreviewTableViewCell`.
    static let userInfoPreviewTableViewCell: Rswift.ReuseIdentifier<SettingUserPreviewTableViewCell> = Rswift.ReuseIdentifier(identifier: "UserInfoPreviewTableViewCell")
    /// Reuse identifier `UserInfoTextTableViewCell`.
    static let userInfoTextTableViewCell: Rswift.ReuseIdentifier<UIKit.UITableViewCell> = Rswift.ReuseIdentifier(identifier: "UserInfoTextTableViewCell")
    
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 3 view controllers.
  struct segue {
    /// This struct is generated for `MainViewController`, and contains static references to 4 segues.
    struct mainViewController {
      /// Segue identifier `mineInfo`.
      static let mineInfo: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, MineInfoViewController> = Rswift.StoryboardSegueIdentifier(identifier: "mineInfo")
      /// Segue identifier `sendNewNovel`.
      static let sendNewNovel: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, SendStartViewController> = Rswift.StoryboardSegueIdentifier(identifier: "sendNewNovel")
      /// Segue identifier `sendNode`.
      static let sendNode: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, SendNodeViewController> = Rswift.StoryboardSegueIdentifier(identifier: "sendNode")
      /// Segue identifier `showDetail`.
      static let showDetail: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MainViewController, NovelDetailViewController> = Rswift.StoryboardSegueIdentifier(identifier: "showDetail")
      
      /// Optionally returns a typed version of segue `mineInfo`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func mineInfo(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, MineInfoViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.mineInfo, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `sendNewNovel`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func sendNewNovel(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, SendStartViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.sendNewNovel, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `sendNode`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func sendNode(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, SendNodeViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.sendNode, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `showDetail`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func showDetail(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MainViewController, NovelDetailViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mainViewController.showDetail, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `MineInfoViewController`, and contains static references to 2 segues.
    struct mineInfoViewController {
      /// Segue identifier `about`.
      static let about: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MineInfoViewController, UIKit.UIViewController> = Rswift.StoryboardSegueIdentifier(identifier: "about")
      /// Segue identifier `settingList`.
      static let settingList: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, MineInfoViewController, SettingViewController> = Rswift.StoryboardSegueIdentifier(identifier: "settingList")
      
      /// Optionally returns a typed version of segue `about`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func about(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MineInfoViewController, UIKit.UIViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mineInfoViewController.about, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `settingList`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func settingList(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, MineInfoViewController, SettingViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.mineInfoViewController.settingList, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    /// This struct is generated for `NovelDetailViewController`, and contains static references to 2 segues.
    struct novelDetailViewController {
      /// Segue identifier `sendNode`.
      static let sendNode: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, NovelDetailViewController, SendNodeViewController> = Rswift.StoryboardSegueIdentifier(identifier: "sendNode")
      /// Segue identifier `showDetail`.
      static let showDetail: Rswift.StoryboardSegueIdentifier<UIKit.UIStoryboardSegue, NovelDetailViewController, NovelDetailViewController> = Rswift.StoryboardSegueIdentifier(identifier: "showDetail")
      
      /// Optionally returns a typed version of segue `sendNode`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func sendNode(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, NovelDetailViewController, SendNodeViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.novelDetailViewController.sendNode, segue: segue)
      }
      
      /// Optionally returns a typed version of segue `showDetail`.
      /// Returns nil if either the segue identifier, the source, destination, or segue types don't match.
      /// For use inside `prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)`.
      static func showDetail(segue: UIKit.UIStoryboardSegue) -> Rswift.TypedStoryboardSegueInfo<UIKit.UIStoryboardSegue, NovelDetailViewController, NovelDetailViewController>? {
        return Rswift.TypedStoryboardSegueInfo(segueIdentifier: R.segue.novelDetailViewController.showDetail, segue: segue)
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 7 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `LoginViewController`.
    static let loginViewController = _R.storyboard.loginViewController()
    /// Storyboard `MainViewController`.
    static let mainViewController = _R.storyboard.mainViewController()
    /// Storyboard `MineInfoViewController`.
    static let mineInfoViewController = _R.storyboard.mineInfoViewController()
    /// Storyboard `NovelDetailViewController`.
    static let novelDetailViewController = _R.storyboard.novelDetailViewController()
    /// Storyboard `SendNodeViewController`.
    static let sendNodeViewController = _R.storyboard.sendNodeViewController()
    /// Storyboard `SendStartViewController`.
    static let sendStartViewController = _R.storyboard.sendStartViewController()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "LoginViewController", bundle: ...)`
    static func loginViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.loginViewController)
    }
    
    /// `UIStoryboard(name: "MainViewController", bundle: ...)`
    static func mainViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.mainViewController)
    }
    
    /// `UIStoryboard(name: "MineInfoViewController", bundle: ...)`
    static func mineInfoViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.mineInfoViewController)
    }
    
    /// `UIStoryboard(name: "NovelDetailViewController", bundle: ...)`
    static func novelDetailViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.novelDetailViewController)
    }
    
    /// `UIStoryboard(name: "SendNodeViewController", bundle: ...)`
    static func sendNodeViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.sendNodeViewController)
    }
    
    /// `UIStoryboard(name: "SendStartViewController", bundle: ...)`
    static func sendStartViewController(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.sendStartViewController)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try sendStartViewController.validate()
      try novelDetailViewController.validate()
      try mainViewController.validate()
      try launchScreen.validate()
      try mineInfoViewController.validate()
      try sendNodeViewController.validate()
      try loginViewController.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "login_logo") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_logo' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct loginViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = LoginViewController
      
      let bundle = R.hostingBundle
      let name = "LoginViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "login_btn_phone_bg") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_btn_phone_bg' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "login_btn_facebook_bg") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_btn_facebook_bg' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "login_btn_weibo_bg") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_btn_weibo_bg' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "login_logo") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'login_logo' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "btn_gray_round_border_bg") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'btn_gray_round_border_bg' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icon_close") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_close' is used in storyboard 'LoginViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct mainViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController
      
      let bundle = R.hostingBundle
      let mainViewController = StoryboardViewControllerResource<MainViewController>(identifier: "MainViewController")
      let name = "MainViewController"
      
      func mainViewController(_: Void = ()) -> MainViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: mainViewController)
      }
      
      static func validate() throws {
        if UIKit.UIImage(named: "control_mask_view") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'control_mask_view' is used in storyboard 'MainViewController', but couldn't be loaded.") }
        if _R.storyboard.mainViewController().mainViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'mainViewController' could not be loaded from storyboard 'MainViewController' as 'MainViewController'.") }
      }
      
      fileprivate init() {}
    }
    
    struct mineInfoViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MineInfoViewController
      
      let bundle = R.hostingBundle
      let name = "MineInfoViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "text_avatar") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'text_avatar' is used in storyboard 'MineInfoViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct novelDetailViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = NovelDetailViewController
      
      let bundle = R.hostingBundle
      let name = "NovelDetailViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "control_mask_view") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'control_mask_view' is used in storyboard 'NovelDetailViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "resize_button") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'resize_button' is used in storyboard 'NovelDetailViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct sendNodeViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SendNodeViewController
      
      let bundle = R.hostingBundle
      let name = "SendNodeViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "icon_commit") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_commit' is used in storyboard 'SendNodeViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "text_avatar") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'text_avatar' is used in storyboard 'SendNodeViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icon_close") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_close' is used in storyboard 'SendNodeViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct sendStartViewController: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = SendStartViewController
      
      let bundle = R.hostingBundle
      let name = "SendStartViewController"
      
      static func validate() throws {
        if UIKit.UIImage(named: "icon_commit") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_commit' is used in storyboard 'SendStartViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "text_avatar") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'text_avatar' is used in storyboard 'SendStartViewController', but couldn't be loaded.") }
        if UIKit.UIImage(named: "icon_close") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'icon_close' is used in storyboard 'SendStartViewController', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}