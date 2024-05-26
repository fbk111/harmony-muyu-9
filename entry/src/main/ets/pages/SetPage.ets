import common from '@ohos.app.ability.common'
import Want from '@ohos.app.ability.Want'
import Prompt from '@system.prompt'
import { CommonConstants } from '../common/CommonConstants'
import { AutoTapSettingEntity } from '../entity/GlobalSettingEntity'
import { IconSetEntity, IconTextEntity } from '../entity/IconEntity'
import {
  FuncInputCommonComp,
  FuncInputTextRadioComp,
  FuncTextComp,
  functionInstruct,
  IconImageComp
} from '../model/CommonComponents'
import MNavigation from '../model/navigation/MNavigation'
import { RouteConstants } from '../route/RouteConstants'
import routerUtils from '../route/RouterUtils'
import PreferencesManager from '../utils/PreferencesMangerUtils'
import preferencesManager from '../utils/PreferencesMangerUtils'

@Entry
@Component
export default struct SetPage {
  private context = getContext(this) as common.UIAbilityContext;
  private iconList: IconSetEntity[] = CommonConstants.iconList
  @Watch('watchCurrentIndex')
  @State
  private currentIndex: number = 0
  @Watch("putIsShowText")
  @State
  private isShowText: boolean = false
  @State
  private inputTextValue: string = ''
  @State
  private isAutoTap: boolean = false
  private iconTextEntity: IconTextEntity = {
    index: this.currentIndex,
    text: ''
  }

  @Styles
  backgroundStyles() {
    .width('100%')
    .height('100%')
    .backgroundColor($r('app.color.page_background_color'))
  }

  @Styles
  cardStyles(){
    .width('95%')
    .padding({ left: 10, right: 10, top: 5, bottom: 5 })
    .backgroundColor('white')
    .borderRadius(5)
  }

  @Styles
  chooseIconStyles(){
    .border({ width: 2, color: $r('app.color.border_icon_color') })
  }

  async watchCurrentIndex() {
    await preferencesManager.put(getContext(this), 'iconEntity', this.currentIndex.toString())
    if (this.isShowText) {
      this.inputTextValue = ''
      let reloadIsShowText = await preferencesManager.get(getContext(this), 'iconTextEntity' + this.currentIndex, JSON.stringify(this.iconTextEntity))
      let temp = (JSON.parse(reloadIsShowText as string) as IconTextEntity)?.text
      this.inputTextValue = temp
    }
  }

  async getCurrentIndex() {
    let reload = await preferencesManager.get(getContext(this), 'iconEntity', "0")
    this.currentIndex = Number(reload)
    let reloadIsShow = await preferencesManager.get(getContext(this), 'isShowText', 'false')
    this.isShowText = reloadIsShow == 'false' ? false : true;
    if (this.isShowText) {
      let reloadIsShowText = await preferencesManager.get(getContext(this), 'iconTextEntity' + this.currentIndex, JSON.stringify(this.iconTextEntity))
      let temp = (JSON.parse(reloadIsShowText as string) as IconTextEntity)?.text
      this.inputTextValue = temp
    }
  }

  async getAutoSetting() {
    let tempAutoTapSetting = await PreferencesManager.get(getContext(this), 'autoTapEntity', "")
    if (tempAutoTapSetting) {
      let autoTapSetting: AutoTapSettingEntity = JSON.parse(tempAutoTapSetting as string)
      this.isAutoTap = autoTapSetting.autoTap
    }
  }

  async putAutoSetting() {
    let autoTapSetting: AutoTapSettingEntity = {
      autoTap: this.isAutoTap
    }
    await PreferencesManager.put(getContext(this), 'autoTapEntity', JSON.stringify(autoTapSetting))
  }

  async putIsShowText() {
    if (this.isShowText) {
      this.inputTextValue = ''
      let reloadIsShowText = await preferencesManager.get(getContext(this), 'iconTextEntity' + this.currentIndex, JSON.stringify(this.iconTextEntity))
      let temp = (JSON.parse(reloadIsShowText as string) as IconTextEntity)?.text
      this.inputTextValue = temp
    }
    let isShowText: string = this.isShowText + ""
    await preferencesManager.put(getContext(this), 'isShowText', isShowText)
  }

  async onPageShow(): Promise<void> {
    await this.getCurrentIndex()
    await this.getAutoSetting()
  }

  async onPageHide(): Promise<void> {
    await this.putAutoSetting()

  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      MNavigation({ title: '偏好设置', rightText: '关闭' })
      Scroll() {
        Column() {
          functionInstruct({ title: '运行模式' })
          Column() {
            FuncInputCommonComp({
              title: '自动敲击', isShow: $isAutoTap, icon: $r('app.media.auto_icon')
            })
          }
          .cardStyles()

          functionInstruct({ title: '敲击提示' })
          Column() {
            FuncInputTextRadioComp({ isShowText: $isShowText })
            if (this.isShowText) {
              TextInput({ placeholder: '请输入自定义的文本', text: this.inputTextValue })
                .fontSize(12)
                .placeholderFont({
                  size: 12
                })
                .backgroundColor('white')
                .placeholderColor('#c4c4c4')
                .onChange((value) => {
                  this.inputTextValue = value
                  const iconTextEntity: IconTextEntity = {
                    index: this.currentIndex,
                    text: value
                  }
                  preferencesManager.put(getContext(this), 'iconTextEntity' + this.currentIndex, JSON.stringify(iconTextEntity))
                })
            }
          }
          .cardStyles()

          functionInstruct({ title: '乐器' })
          Column() {
            FuncTextComp({
              title: '全部乐器',
              rightTitle: this.iconList.length.toString(),
              iconBackColor: $r('app.color.icon_func_introduce_back_yueqi_color')
            })
            Grid() {
              ForEach(this.iconList, (item: IconSetEntity, index) => {
                GridItem() {
                  IconImageComp({ index: item.index, color: item.color, icon: item.icon, currentIndex: $currentIndex })
                    .margin(3)
                    .borderRadius(8)
                    .border({
                      width: 3,
                      color: this.currentIndex == index ? $r('app.color.border_icon_color') : 'white'
                    })
                    .onClick(async () => {
                      this.currentIndex = index
                    })
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr 1fr')
            .width('100%')
            .height(200)
          }
          .cardStyles()

          functionInstruct({ title: '高级设置' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.set'),
              iconBackColor: $r('app.color.icon_func_introduce_back_setting_color'),
              title: '高级设置',
              rightTitle: '>'
            })
          }
          .cardStyles()
          .onClick(() => {
            routerUtils.push(RouteConstants.highSetPage)
          })

          functionInstruct({ title: '自定义' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.customize_icon'),
              iconBackColor: 'white',
              title: '自定义 icon 和 audio',
              rightTitle: '>'
            })
          }
          .cardStyles()
          .onClick(() => {
            routerUtils.push(RouteConstants.customizePage)
          })


          functionInstruct({ title: '爱心' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.love'),
              iconBackColor: $r('app.color.icon_boom_white'),
              title: '给我赞助一杯可乐',
            })
          }
          .cardStyles()

          functionInstruct({ title: 'about me' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.blog'),
              iconBackColor: $r('app.color.icon_fangpi_white'),
              title: '博客',
            })
              .onClick(() => {
                let wantInfo: Want = {
                  action: 'ohos.want.action.viewData',
                  entities: ['entity.system.browsable'],
                  uri: 'https://blog.fbk111.top/'
                }
                this.context.startAbility(wantInfo).then(() => {
                  // ...
                }).catch((err: Error) => {
                  // ...
                })
              })
          }
          .cardStyles()

          functionInstruct({ title: '反馈' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.replay'),
              iconBackColor: $r('app.color.icon_fangpi_white'),
              title: '反馈 bug',
            })
              .onClick(() => {
                let wantInfo: Want = {
                  action: 'ohos.want.action.viewData',
                  entities: ['entity.system.browsable'],
                  uri: 'https://docs.qq.com/form/page/DQUpQd3lndk1mbFlD'
                }
                this.context.startAbility(wantInfo).then(() => {
                  // ...
                }).catch((err: Error) => {
                  // ...
                })
              })
            FuncTextComp({
              icon: $r('app.media.replay'),
              iconBackColor: $r('app.color.icon_fangpi_white'),
              title: '提出建议',
            })
              .onClick(() => {
                let wantInfo: Want = {
                  // uncomment line below if wish to implicitly query only in the specific bundle.
                  // bundleName: 'com.example.myapplication',
                  action: 'ohos.want.action.viewData',
                  // entities can be omitted.
                  entities: ['entity.system.browsable'],
                  uri: 'https://docs.qq.com/form/page/DQXdyR1ltSnR2ZndG'
                }
                this.context.startAbility(wantInfo).then(() => {
                  // ...
                }).catch((err: Error) => {
                  // ...
                })
              })
          }
          .margin({ bottom: 50 })
          .cardStyles()
        }
      }
      .width('100%')
      .margin({ top: 100 })
      .scrollBar(BarState.Off)
    }
    .backgroundStyles()
  }
}