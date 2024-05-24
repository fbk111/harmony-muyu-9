import router from '@ohos.router'

@Component
export default struct MNavigation {
  private title: string = ""
  private rightText: string = ""

  build() {
    Stack() {
      Row() {
        Text(this.title)
          .fontWeight(800)
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .height('100%')

      Row() {
        Text(this.rightText)
          .padding({ right: 30,left:30 })
          .fontColor($r('app.color.nav_title_button_color'))
          .fontSize(15)
          .decoration({
            type: TextDecorationType.Underline,
            color: $r('app.color.nav_title_button_color')
          })
          .onClick(() => {
            router.back()
          })
          .height('100%')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.End)
    }
    .width('100%')
    .height(100)
    .padding({top:50})
    .backgroundColor($r('app.color.nav_background_color'))
  }
}