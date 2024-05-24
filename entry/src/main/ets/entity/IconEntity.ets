export class IconSetEntity {
  index: number = 0;
  icon: ResourceStr = ''
  color: ResourceStr = ''
  audio: ResourceStr = ''
  // constructor(index:number,icon:ResourceStr,color:ResourceStr) {
  //   this.index=index
  //   this.icon=icon
  //   this.color=color
  // }

}

export class IconTextEntity {
  index: number = 0;
  text: string = '';
}

export interface AudioData {
  name: string;
  uri: string;
  size: number;
  time: number;
  duration: number;
  height: string
}


export class IconDataSource implements IDataSource {
  private list: IconSetEntity[] = []

  constructor(list: IconSetEntity[]) {
    this.list = list
  }

  totalCount(): number {
    return this.list.length
  }

  getData(index: number): IconSetEntity {
    return this.list[index]
  }

  registerDataChangeListener(listener: DataChangeListener): void {
  }

  unregisterDataChangeListener() {
  }
}