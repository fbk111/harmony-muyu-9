import picker from '@ohos.file.picker';
import Prompt from '@system.prompt';
import { FuncTextComp, functionInstruct } from '../model/CommonComponents';
import MNavigation from '../model/navigation/MNavigation'
import RecordManager from '../manager/RecordManager';
import mediaLibrary from '@ohos.multimedia.mediaLibrary';
import MediaManager from '../manager/MediaManager';

@Entry
@Component
struct CustomizePage {
  @State
  private uri: string = ''
  private audioFile?: mediaLibrary.FileAsset;
  @State
  private audioFunctionTitle: string = '录制我的音频'

  private fd?: number;

  @State fileName: string = '';

  private recorder: RecordManager = new RecordManager();

  private isRecording:boolean=false
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

  async chooseIcon() {
    this.uri = ''
    const photoSelectOptions = new picker.PhotoSelectOptions();
    photoSelectOptions.MIMEType = picker.PhotoViewMIMETypes.IMAGE_TYPE; // 过滤选择媒体文件类型为IMAGE
    photoSelectOptions.maxSelectNumber = 1; // 选择媒体文件的最大数目
    const photoViewPicker = new picker.PhotoViewPicker();
    let photos = await photoViewPicker.select(photoSelectOptions)
    this.uri = photos.photoUris[0]
  }

  async chooseAudio() {
    let audioSelectOptions = new picker.AudioSelectOptions();
    let audioPicker = new picker.AudioViewPicker();
    audioPicker.select(audioSelectOptions).then((AudioSelectResult) => {
      Prompt.showToast({
        message: AudioSelectResult[0].toString(),
        duration: 20000
      })
      console.info('AudioViewPicker.select successfully, AudioSelectResult uri: ' + JSON.stringify(AudioSelectResult));
    }).catch((err) => {
      console.error('AudioViewPicker.select failed with err: ' + err);
    });
  }

  // 开始录制对应的流程
  async startRecordingProcess() {
    let dirPath = pathDir + "/testDir";
    fs.mkdirSync(dirPath);
    this.recorder.start(`fd://${this.fd}`);
  }
  // 停止录制对应的流程
  async stopRecordingProcess() {
    this.recorder.finish()
    this.recorder.release()
    await this.audioFile!.close(this.fd!);
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      MNavigation({ title: '自定义', rightText: '偏好设置' })
      Scroll() {
        Column() {
          functionInstruct({ title: '功能' })
          Column() {
            FuncTextComp({
              icon: $r('app.media.customize_icon'),
              iconBackColor: 'white',
              title: '选择 icon',
            })
          }
          .cardStyles()
          .onClick(() => {
            this.chooseIcon()
          })

          Column() {
            FuncTextComp({
              icon: $r('app.media.customize_icon'),
              iconBackColor: 'white',
              title: '选择 audio',
            })
          }
          .onClick(() => {
            this.chooseAudio()
          })
          .cardStyles()

          Column() {
            FuncTextComp({
              icon: $r('app.media.customize_icon'),
              iconBackColor: 'white',
              title: this.audioFunctionTitle,
            })
          }
          .onClick(() => {
            console.log('2222')
            // 1. 停止录制
            if (this.isRecording) { // 仅在started或者paused状态下调用stop为合理状态切换
              this.audioFunctionTitle = '录制我的音频'
              this.stopRecordingProcess()
            } else {
              this.audioFunctionTitle = '正在录制......'
              this.startRecordingProcess()
            }
            this.isRecording=!this.isRecording
          })
          .cardStyles()

          functionInstruct({ title: '我的音频列表' })

          if (this.uri != '') {
            Column() {
              Image(this.uri)
                .width(230)
                .margin({ top: 30 })
            }
            .width('100%')
            .height(280)
            .backgroundColor('black')

            Column() {
              FuncTextComp({
                icon: $r('app.media.customize_icon'),
                iconBackColor: 'white',
                title: '添加到我的 icon 集合',
              })
            }
            .cardStyles()
            .margin({ top: 30 })
            .onClick(() => {
            })
          }
        }
        .width('100%')
        .height('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
      .margin({ top: 100 })
    }
    .backgroundStyles()
  }
}