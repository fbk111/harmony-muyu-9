import { IconDataSource, IconSetEntity, IconTextEntity } from '../entity/IconEntity'
import preferencesManager from '../utils/PreferencesMangerUtils'
import data_preferences from '@ohos.data.preferences';
import { CommonConstants } from '../common/CommonConstants'
import { IndexIconImageComp } from '../model/CommonComponents';
import { AutoTapSettingEntity, ShowSettingEntity } from '../entity/GlobalSettingEntity';
import routerUtils from '../route/RouterUtils';
import { RouteConstants } from '../route/RouteConstants';
import PreferencesManager from '../utils/PreferencesMangerUtils';
import window from '@ohos.window';
import vibrator from '@ohos.vibrator';
import media from '@ohos.multimedia.media';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct Index {
  private windowClass: window.Window | undefined = undefined;
  private avPlayer?: media.AVPlayer = undefined;
  private autoTapIntervel: number = 0
  @State
  private currentIconEntity: IconSetEntity = new IconSetEntity()
  private currentTextEntity: IconTextEntity = {
    index: 0,
    text: ''
  }
  @State
  private text: string = ''
  @State
  private isShowText: boolean = false
  @State
  private currentIndex: number = 0
  @State
  private quickChangeAudio: boolean = false
  @State
  private audioSmartPlayer?: media.AVPlayer = undefined;
  @State
  private currentNumber: number = 0;
  @State
  private totalNumber: number = 0
  private speed: number = 300;
  @State
  private iconScaleOptions: ScaleOptions = {
    x: 0.9,
    y: 0.9
  }
  @State
  private textTranslateOptions: TranslateOptions = {
    y: 0
  }
  @State
  private isAutoTap: boolean = false
  @State
  private isShowCalculateNumber: boolean = true
  private textOpacity: number = 0

  @Styles
  backgroundStyles(){
    .width('100%')
    .height('100%')
    .backgroundColor(this.currentIconEntity.color)
  }

  @Builder
  TabBarBuilder(icon: ResourceStr, back: ResourceStr) {
    Row() {
      Image(icon)
        .width(20)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor(back)
  }

  async onPageShow(): Promise<void> {
    if (!this.avPlayer || !this.audioSmartPlayer) {
      this.initSmartAudio()
    }
    if (this.windowClass) {
      this.initWindowClass()
    }
    this.getCurrentIconEntity()
    this.getHighLevelEntity()
    this.getClickNumber()
    this.getAutoSetting()
  }

  async onPageHide(): Promise<void> {
    this.audioSmartPlayer?.release()
    this.putClickNumber()
    clearInterval(this.autoTapIntervel)
  }

  async getAutoSetting() {
    let tempAutoTapSetting = await PreferencesManager.get(getContext(this), 'autoTapEntity', "")
    if (tempAutoTapSetting) {
      let autoTapSetting: AutoTapSettingEntity = JSON.parse(tempAutoTapSetting as string)
      this.isAutoTap = autoTapSetting.autoTap
      if (this.isAutoTap) {
        this.autoTapIntervel = setInterval(() => {
          this.knock()
        }, 1000)
      }
    }
  }

  async initWindowClass() {
    let config: window.Configuration = {
      name: "index",
      windowType: window.WindowType.TYPE_FLOAT,
      ctx: getContext(this)
    };
    try {
      window.createWindow(config, (err: Error, data) => {
        const errMessage: string = err.message;
        if (errMessage) {
          console.error('Failed to create the window. Cause: ' + JSON.stringify(err));
          return;
        }
        this.windowClass = data;
        console.info('Succeeded in creating the window. Data: ' + JSON.stringify(data));
      });
    } catch (exception) {
      console.error('Failed to create the window. Cause: ' + JSON.stringify(exception));
    }
  }

  async getClickNumber() {
    let temp = Number(await PreferencesManager.get(getContext(this), 'clickNumber', "0"))
    this.totalNumber = temp
  }

  async putClickNumber() {
    let totalNumber: string = this.totalNumber + ""
    this.currentNumber = 0
    PreferencesManager.put(getContext(this), 'clickNumber', totalNumber)
  }

  async getHighLevelEntity() {
    let showSettingString = await preferencesManager.get(getContext(this), 'showSettingEntity', "")
    if (showSettingString) {
      let showSettingEntity: ShowSettingEntity = JSON.parse(showSettingString as string)
      this.quickChangeAudio = showSettingEntity?.quickChangeAudio
      this.isShowCalculateNumber = showSettingEntity.showCalculateNumber
    }
  }

  async getCurrentIconEntity() {
    let preferenceData: data_preferences.ValueType = await preferencesManager.get(getContext(this), 'iconEntity', "0")
    let reload = CommonConstants.iconList[Number(preferenceData)]
    this.currentIconEntity = JSON.parse(JSON.stringify(reload))
    this.currentIndex = this.currentIconEntity.index
    let reloadIsShow = await preferencesManager.get(getContext(this), 'isShowText', 'false')
    this.isShowText = reloadIsShow == 'false' ? false : true;
    this.initSmartAudio(this.currentIconEntity.audio as string)
    if (this.isShowText) {
      let textEntity: data_preferences.ValueType = await preferencesManager.get(getContext(this), 'iconTextEntity' + reload.index, JSON.stringify(this.currentTextEntity))
      let reloadText: IconTextEntity = JSON.parse(textEntity as string) as IconTextEntity
      this.text = reloadText.text
    }

  }

  async initSmartAudio(audio: string = "muyu_audio.mp3") {
    this.avPlayer = await media.createAVPlayer();
    let context = getContext(this) as common.UIAbilityContext
    let audioSrc = await context.resourceManager.getRawFd(audio)
    this.avPlayer.fdSrc = audioSrc
    this.audioSmartPlayer = this.avPlayer
  }

  // 触发手机振动效果
  startVibrate() {
    try {
      vibrator.startVibration({
        type: 'time',
        duration: 200,
      }, {
        id: 0,
        usage: 'simulateReality',
      }, (error: Error) => {
        if (error) {
          console.error(`Failed to start vibration, message: ${error.message}`);
          return;
        }
      });
    } catch (err) {
      console.error(`An unexpected error occurred. Code: ${err.code}, message: ${err.message}`);
    }
  }

  private knock() {
    this.audioSmartPlayer?.stop(() => {
      this.audioSmartPlayer?.prepare(() => {
        this.audioSmartPlayer?.play()
        this.startVibrate()
      })
    })
    this.currentNumber++;
    this.totalNumber++;
    animateTo({
      duration: this.speed, onFinish: () => {
        this.textOpacity = 0
        this.textTranslateOptions = {
          y: 0
        }
        this.iconScaleOptions = {
          x: 0.9,
          y: 0.9
        }
      }
    }, () => {
      this.textOpacity = 1
      this.textTranslateOptions = {
        y: -30
      }
      this.iconScaleOptions = {
        x: 1,
        y: 1
      }
    })
  }

  @Builder
  headerBuilder() {
    Row() {
      if (this.isShowCalculateNumber) {
        Column() {
          Text(this.currentNumber.toString())
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Text(this.totalNumber.toString())
            .fontSize(13)
            .fontColor(Color.White)
        }
      }


      Blank()
      if (this.isAutoTap) {
        Image($r('app.media.stop_icon'))
          .width(25)
          .height(25)
          .margin({ right: 20 })
          .onClick(async () => {
            clearInterval(this.autoTapIntervel)
            this.isAutoTap = false
            let autoTapSetting: AutoTapSettingEntity = {
              autoTap: false
            }
            await PreferencesManager.put(getContext(this), 'autoTapEntity', JSON.stringify(autoTapSetting))
          })
      }
      Image($r('app.media.set'))
        .width(25)
        .height(25)
        .onClick(() => {
          routerUtils.push(RouteConstants.setPage)
        })
    }
    .margin({ top: 20 })
    .width('100%')
    .alignItems(VerticalAlign.Center)

  }

  @Builder
  contentHeader() {
    Column() {
      Image(this.currentIconEntity.icon).width(230)
        .onClick(() => {
          if (!this.isAutoTap) {
            this.knock()
          }
        })
        .scale(this.iconScaleOptions)
    }
    .width('100%')
    .margin({ top: 180 })
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Stack() {
      Column() {
        // 总功德数
        this.headerBuilder()
        // 功德+1 文字动效
        if (this.isShowText) {
          Text(this.text)
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .textAlign(TextAlign.Center)
            .width('100%')
            .translate(this.textTranslateOptions)
            .position({ y: 150 })
            .opacity(this.textOpacity)
        }
        this.contentHeader()
      }
      .width('100%')
      .height('100%')
      .padding(12)
      .backgroundColor(this.currentIconEntity.color)
      .alignItems(HorizontalAlign.Start)


      if (this.quickChangeAudio) {
        Swiper() {
          LazyForEach(new IconDataSource(CommonConstants.iconList), (item: IconSetEntity, index: number) => {
            IndexIconImageComp({ color: item.color, icon: item.icon })
              .onClick(async () => {
                await PreferencesManager.put(getContext(this), 'iconEntity', index)
                this.currentIndex = index
                this.getCurrentIconEntity()
              })
              .borderRadius(8)
              .border({ width: 3, color: this.currentIndex == index ? $r('app.color.border_icon_color') : 'white' })
          }, (item: string) => item)

        }
        .height(50)
        .displayCount(6)
        .itemSpace(10)
        .position({ y: 700 })
        .indicator(false)
        .padding({ left: 10, right: 10 })
      }

    }
    .backgroundStyles()
  }
}