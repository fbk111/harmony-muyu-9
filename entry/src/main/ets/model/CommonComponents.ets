import { CommonConstants } from '../common/CommonConstants'
import FunctionCallBack from '../entity/CallBack'
import PreferencesManager from '../utils/PreferencesMangerUtils'

@Component
export struct SubTitleComp {
  private title: ResourceStr = ""

  build() {
    Row() {
      Text(this.title)
        .fontSize(13)
        .fontColor($r('app.color.sub_title_color'))
        .padding(50)
    }
    .width('100%')
    .height(30)
  }
}

@Component
export struct FuncInputTextRadioComp {
  @Link
  private isShowText: boolean

  build() {
    Row() {
      Image($r('app.media.text_title_icon'))
        .width(CommonConstants.func_icon_size)
        .height(CommonConstants.func_icon_size)
        .border({ radius: 3 })
      Text('敲击显示文字')
        .padding({ left: 10 })
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.isShowText })
        .selectedColor($r('app.color.radio_button_color'))
        .onChange((isShow: boolean) => {
          this.isShowText = isShow
          PreferencesManager.put(getContext(this), 'isShowText', isShow)
        })
    }
    .width('100%')
    .height(50)
  }
}

@Component
export struct FuncInputCommonComp {
  @Link
  private isShow: boolean
  private title: string = ''
  private icon: ResourceStr = $r('app.media.text_title_icon')
  private callBackFunc: FunctionCallBack = () => {
  };

  build() {
    Row() {
      Image(this.icon)
        .width(CommonConstants.func_icon_size)
        .height(CommonConstants.func_icon_size)
        .border({ radius: 3 })
      Text(this.title)
        .padding({ left: 10 })
      Blank()
      Toggle({ type: ToggleType.Switch, isOn: this.isShow })
        .selectedColor($r('app.color.radio_button_color'))
        .onChange((isShow: boolean) => {
          this.isShow = isShow
          if (this.callBackFunc) {
            this.callBackFunc()
          }
        })
    }
    .width('100%')
    .height(50)
  }
}

@Component
export struct FuncTextComp {
  @Prop
  private title: string
  private icon: ResourceStr = $r('app.media.music')
  private iconBackColor: ResourceStr = $r('app.color.icon_func_introduce_back_yueqi_color')
  private rightTitle: string = ""

  build() {
    Row() {
      Row() {
        Image(this.icon)
          .width(CommonConstants.func_icon_size)
          .height(CommonConstants.func_icon_size)
      }
      .border({ radius: 3 })
      .backgroundColor(this.iconBackColor)
      .padding(2)

      Text(this.title)
        .padding({ left: 10 })
      Blank()
      Text(this.rightTitle)
        .fontColor($r('app.color.sub_title_color'))
    }
    .width('100%')
    .height(50)
  }
}

@Component
export struct IconImageComp {
  private icon: ResourceStr = ""
  private color: ResourceStr = ""
  private preferenceIndexIcon: string = ''
  private index: number = 0;
  @Link
  private currentIndex: number

  @Styles
  chooseIconStyles(){
    .border({ width: 3, color: $r('app.color.border_icon_color') })
  }

  build() {
    Row() {
      Text(this.preferenceIndexIcon)
      Image(this.icon)
        .width('100%')
    }
    .padding(10)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.color)
    .width(50)
    .height(50)
    .onClick(() => {
      console.log(this.currentIndex.toString(), this.index.toString())
      PreferencesManager.put(getContext(this), 'iconEntity', this.index)
      this.currentIndex = this.index
    })
  }
}

@Component
export struct IndexIconImageComp {
  private icon: ResourceStr = ""
  private color: ResourceStr = ""
  private preferenceIndexIcon: string = ''

  @Styles
  chooseIconStyles(){
    .border({ width: 3, color: $r('app.color.border_icon_color') })
  }

  build() {
    Row() {
      Text(this.preferenceIndexIcon)
      Image(this.icon)
        .width('90%')
    }
    .justifyContent(FlexAlign.Center)
    .backgroundColor(this.color)
    .width('100%')
    .height('100%')
  }
}

@Component
export struct functionInstruct {
  private title: string = ""

  build() {
    Row() {
      Text(this.title)
        .fontSize(12)
        .fontColor('grep')
        .padding({ left: 10 })
    }
    .padding({ left: 20, bottom: 5, top: 10 })
    .width('100%')
  }
}