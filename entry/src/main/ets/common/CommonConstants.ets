import { ShowSettingEntity } from '../entity/GlobalSettingEntity';
import { IconSetEntity } from '../entity/IconEntity';

export class CommonConstants {
  static readonly nav_icon_size: number = 30
  static readonly func_icon_size: number = 25
  static readonly PREFERENCES_NAME = "PREFERENCES_NAME"
  static readonly MUYU_DEFAULT_NAME = "功德 + 1"
  /**
   * avplayer闲置状态
   */
  static readonly AVPLAYER_STATE_IDLE = 'idle';
  /**
   * avplayer资源初始化状态
   */
  static readonly AVPLAYER_STATE_INITIALIZED = 'initialized';
  /**
   * avplayer已准备状态
   */
  static readonly AVPLAYER_STATE_PREPARED = 'prepared';
  /**
   * avplayer正在播放状态
   */
  static readonly AVPLAYER_STATE_PLAYING = 'playing';
  /**
   * avplayer暂停状态
   */
  static readonly AVPLAYER_STATE_PAUSED = 'paused';
  /**
   * avplayer播放至结尾状态
   */
  static readonly AVPLAYER_STATE_COMPLETED = 'completed';
  /**
   * avplayer停止状态
   */
  static readonly AVPLAYER_STATE_STOPPED = 'stopped';
  /**
   * avplayer销毁状态
   */
  static readonly AVPLAYER_STATE_RELEASED = 'released';
  /**
   * avplayer错误状态
   */
  static readonly AVPLAYER_STATE_ERROR = 'error';
  /**
   * Config of recorder.
   */
  static readonly BIT_RATE: number = 48000;
  static readonly CHANNEL: number = 2;
  static readonly SAMPLE_RATE: number = 48000;
  static readonly LATITUDE: number = 30;
  static readonly LONGITUDE: number = 130;

  /**
   * State of player or recorder.
   */
  static readonly IDLE: string = 'idle';
  static readonly INITIALIZED: string = 'initialized';
  static readonly PREPARED: string = 'prepared';
  static readonly PLAYING: string = 'playing';
  static readonly PAUSED: string = 'paused';
  static readonly COMPLETED: string = 'completed';
  static readonly STARTED: string = 'started';
  static readonly STOPPED: string = 'stopped';
  static readonly RELEASED: string = 'released';
  static readonly ERROR: string = 'error';


  static readonly provinces: string[] = [
    "北京市",
    "天津市",
    "河北省",
    "山西省",
    "内蒙古自治区",
    "辽宁省",
    "吉林省",
    "黑龙江省",
    "上海市",
    "江苏省",
    "浙江省",
    "安徽省",
    "福建省",
    "江西省",
    "山东省",
    "河南省",
    "湖北省",
    "湖南省",
    "广东省",
    "广西壮族自治区",
    "海南省",
    "重庆市",
    "四川省",
    "贵州省",
    "云南省",
    "西藏自治区",
    "陕西省",
    "甘肃省",
    "青海省",
    "宁夏回族自治区",
    "新疆维吾尔自治区",
    "香港特别行政区",
    "澳门特别行政区"
  ];
  static readonly iconList: IconSetEntity[] = [
    {
      index: 0,
      icon: $r('app.media.muyutou_white'),
      color: $r('app.color.icon_muyutou_black'),
      audio: "muyu_audio.mp3"
    },
    {
      index: 1,
      icon: $r('app.media.muyutou_yellow'),
      color: $r('app.color.icon_muyutou_green'),
      audio: "muyu_audio.mp3"
    },
    {
      index: 2,
      icon: $r('app.media.muyutou_red'),
      color: $r('app.color.icon_muyutou_yellow'),
      audio: "muyu_audio.mp3"
    },
    {
      index: 3,
      icon: $r('app.media.muyutou_sliver'),
      color: $r('app.color.icon_muyutou_blue'),
      audio: "muyu_audio.mp3"
    },
    {
      index: 4,
      icon: $r('app.media.kunkun_icon_yellow'),
      color: $r('app.color.icon_kunkun_yellow'),
      audio: "kunkun_ayw_audio.mp3"
    },
    {
      index: 5,
      icon: $r('app.media.kunkun_icon_blue'),
      color: $r('app.color.icon_kunkun_blue'),
      audio: "kunkun_zy_audio.mp3"
    },
    {
      index: 6,
      icon: $r('app.media.lightning'),
      color: $r('app.color.icon_lighting_grown'),
      audio: "lighting_audio.mp3"
    },
    {
      index: 7,
      icon: $r("app.media.graphic_bell_icon"),
      color: $r('app.color.icon_bell_yellow'),
      audio: "bells_audio.mp3"
    },
    {
      index: 8,
      icon: $r("app.media.oh_icon"),
      color: $r('app.color.icon_oh_green'),
      audio: "oh_audio.mp3"
    },
    {
      index: 9,
      icon: $r("app.media.shotgun_icon"),
      color: $r('app.color.icon_gun_white'),
      audio: "bun_shout_audio.mp3"
    },
    {
      index: 10,
      icon: $r("app.media.fangpi_icon"),
      color: $r('app.color.icon_fangpi_white'),
      audio: "fangpi_audio.mp3"
    },
    {
      index: 11,
      icon: $r("app.media.boom_icon"),
      color: $r('app.color.icon_boom_white'),
      audio: "boom_audio.mp3"
    },
  // {
  //   index: 11,
  //   icon: $r('app.media.muyutou_white'),
  //   color: $r('app.color.icon_index1_color')
  // },
  // {
  //   index: 12,
  //   icon: $r('app.media.muyutou_white'),
  //   color: $r('app.color.icon_index1_color')
  // },
  // {
  //   index: 13,
  //   icon: $r('app.media.muyutou_white'),
  //   color: $r('app.color.icon_index1_color')
  // },
  // {
  //   index: 14,
  //   icon: $r('app.media.muyutou_white'),
  //   color: $r('app.color.icon_index1_color')
  // },
  // {
  //   index: 15,
  //   icon: $r('app.media.muyutou_white'),
  //   color: $r('app.color.icon_index1_color')
  // }
  ]
  static readonly commonShowSettingEntity: ShowSettingEntity = {
    showCalculateNumber: true,
    audioHint: true,
    keepScreenLight: true,
    quickChangeAudio:false
  }
}

