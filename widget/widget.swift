import WidgetKit
import SwiftUI
import Intents

@main
struct widgets: WidgetBundle {
  
  @WidgetBundleBuilder
  var body: some Widget {
    SmallWidget()
    MediumWidget()
  }
}
