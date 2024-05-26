import data_preferences from '@ohos.data.preferences';

const PREFERENCES_NAME = "PREFERENCES_NAME"

/**
 * 首选项工具类：key只能是字符串类型，value类型：number | string | boolean | Array<number> | Array<string> | Array<boolean>;
 *
 */
class PreferencesManager {
  private static localDataManager: PreferencesManager;

  public static instance() {
    if (!PreferencesManager.localDataManager) {
      PreferencesManager.localDataManager = new PreferencesManager();
    }
    return PreferencesManager.localDataManager;
  }

  public static async put(context: Context, key: string, value: data_preferences.ValueType) {
    let preferences = await data_preferences.getPreferences(context, PREFERENCES_NAME);
    await preferences.put(key, value)
    await preferences.flush()
  }

  public static async get(context: Context, key: string, defaultValue: string) {
    let preferences = await data_preferences.getPreferences(context, PREFERENCES_NAME);
    return await preferences.get(key, defaultValue)
  }

  public static async delete(context: Context, key: string) {
    let preferences = await data_preferences.getPreferences(context, PREFERENCES_NAME);
    await preferences.delete(key)
  }

  async clear(context: Context) {
    let preferences = await data_preferences.getPreferences(context, PREFERENCES_NAME);
    await preferences.clear()
    // preferences.then((res) => {
    //   res.clear().then((value) => {
    //   });
    // });
  }
}

export default PreferencesManager