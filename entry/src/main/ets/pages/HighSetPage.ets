import window from '@ohos.window';
import common from '@ohos.app.ability.common';
import { CommonConstants } from '../common/CommonConstants';
import { ShowSettingEntity } from '../entity/GlobalSettingEntity';
import { FuncInputCommonComp, functionInstruct } from '../model/CommonComponents';
import MNavigation from '../model/navigation/MNavigation';
import PreferencesManager from '../utils/PreferencesMangerUtils';
import Prompt from '@system.prompt';

@Entry
@Component
struct HighSetPage {
  private context: common.BaseContext = getContext(this) as common.BaseContext
  @State
  private isShowCalculateNumber: boolean = true
  @State
  private isAudioHint: boolean = true
  @State
  private isKeepScreenLight: boolean = true
  @State
  private isQuickChangeAudio: boolean = true

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



  async onPageShow(): Promise<void> {
    let showSettingString: string = await PreferencesManager.get(getContext(this), 'showSettingEntity', JSON.stringify(CommonConstants.commonShowSettingEntity)) as string
    const showSettingEntity: ShowSettingEntity = JSON.parse(showSettingString)
    this.isShowCalculateNumber = showSettingEntity.showCalculateNumber
    this.isAudioHint = showSettingEntity.audioHint
    this.isKeepScreenLight = showSettingEntity.keepScreenLight
    this.isQuickChangeAudio = showSettingEntity.quickChangeAudio
  }

  async onPageHide(): Promise<void> {
    let reloadShowSettingEntity: ShowSettingEntity = {
      showCalculateNumber: this.isShowCalculateNumber,
      audioHint: this.isAudioHint,
      keepScreenLight: this.isKeepScreenLight,
      quickChangeAudio: this.isQuickChangeAudio
    }
    await PreferencesManager.put(getContext(this), 'showSettingEntity', JSON.stringify(reloadShowSettingEntity))
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      MNavigation({ title: '高级设置', rightText: '偏好设置' })
      Column() {
        functionInstruct({ title: '敲击统计' })
        Column() {
          FuncInputCommonComp({ title: '显示计数器', isShow: $isShowCalculateNumber })
          FuncInputCommonComp({ title: '音效状态提示', isShow: $isAudioHint })
          FuncInputCommonComp({
            title: '保持屏幕常亮',
            isShow: $isKeepScreenLight,
          })
          FuncInputCommonComp({ title: '音效快捷切换栏', isShow: $isQuickChangeAudio })
        }
        .cardStyles()
      }
      .width('100%')
      .height('100%')
      .margin({ top: 100 })
    }
    .backgroundStyles()
  }
}