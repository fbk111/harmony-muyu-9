
import router from '@ohos.router'
export class RouterUtils {
  push(url: string,params?:string) {
    router.pushUrl({
      url: url,
      params:params,
    }).catch((error:Error)=>{
      console.log(error.message)
    })
  }
}

const routerUtils = new RouterUtils()

export default routerUtils