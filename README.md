# CMPageViewController

**This CMPageViewController** is viewContainer which inherit UIView. It's function just like UIPageViewController but I thinek it's better. It is used as TableView and It will save ViewControllers in RAM in order to avoide make HTTP requests for repeated times.It's effect is simillar to Android's UI.

这个页面控制器是继承UIview的，它的功能像UIPageViewController但是我觉得是更好。使用方式和TableView差不多并且它会储存显示的ViewController来减少页面重复的HTTP请求。它的效果有点像Android的UI。
## Effect
![image](https://github.com/WuChuming/CMPageViewController/blob/master/Untitled.gif)   

## Install steps
**1.** Drop files in a floder called CMpageViewController into your project。

**2.** There are two classes in the floder. One is the ViewController and the other is a class called Appearance which is used for setting the CMpageViewController's profile. You can use a Method called "initWithFrame" to customized your frame. Just like:

CMpageViewController *view = [[CMpageViewController alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

Or you can use "init" Method to initialize object which has a full-frame.

Three Delegate Methods is required. You have to set all of them in order to have a good performance.

Please Check the Demo!

**3.** Enjoy it！！！！！！

**PS：** It welcome to be extended。