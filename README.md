# work_station 介绍
<Span>
    这个Flutter 工位预定App主要包括登陆，对登陆之后Token的存储以便于下一次登陆直接跳过登陆界面。在我要预约界面，首先需要对时间和日历的选择，这两个控件依次为：table_calendar和flutter_datetime_picker。选择完之后进入预定工位界面，这个界面上所有的桌子的存放都是由服务器端传过来的x,y的坐标，根据坐标来绘制每个桌子样式，其中样式包括：可预约样式，已预约样式，已占用样式，不可预约样式。其中，只有可预约样式是允许用户进行点击的，每当用户点击一次，桌子的样式也相应发生一次改变，当前只允许用户预定一张桌子。点击确定之后，会自动向服务器端发送订单，如果下单成功，自动跳转到预定成功界面，下单失败，则弹出预定失败的原因。预约成功界面有两个按钮，“查看详情”和“返回首页”按钮，点击查看详情按钮，直接显示下单的详情，该详情也用户也可以通过点击“取消预约”按钮来取消下单成功的订单。
    首页显示当前用户预约桌子的总个数，点击进去之后通过一张张卡片来展示当前预约各个桌子的信息，点击单个卡片，能够进入该订单的详情。主界面还有预约记录，用于展示该用户当前预约所有订单，包括预约未使用的，使用中的，取消的，过期的，四种不同的状态用四种不同的卡片表示，形成鲜明的对比。考虑到预约记录的数据量比较庞大，采用了下拉加载的设计模式，每次加载十条，当加载所有的记录之后，再次上拉，会提示数据加载完毕的提示。在我的界面当中，顶部的卡片展示着用户的简略信息。该界面主要有两大功能，其一，绑定手机功能：一个账号只能够绑定一个手机号码。修改密码：通过输入当前的密码和新的密码来进行修改。修改成功之后会跳转到登陆界面，用户可以通过输入用户名或者手机号来进行登陆，在用户忘记密码的时候，也可以通过点击忘记密码来通过手机号来重置密码。用户登陆成功之后，客户端和服务器端均会保留一份Token，token的有效期为一个星期，只要在有效期内，用户便可以直接跳过登陆界面。</Span>

## 效果展示

### 登陆界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/login_page.jpg" width = 200 height = 400>
            
### 忘记密码界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/forget_pass_page.jpg" width = 200 height = 400>
    
### 当前座位界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/index_seat_page.jpg" width = 200 height = 400>
    
### Home界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/index_order_page.jpg" width = 200 height = 400>
        
### 当前预约界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/current_order_page.jpg" width = 200 height = 400>
            
### 预约记录界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/current_order_page.jpg" width = 200 height = 400>       
                
### 选择时间界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/select_time_page.jpg" width = 200 height = 400>
                
### 预约桌子界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/current_seat_page.jpg" width = 200 height = 400>
                
### 预约成功界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/order_success_page.jpg" width = 200 height = 400>
                
### 预约详情界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/order.jpg" width = 200 height = 400>
                
### 我的界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/index_me_page.jpg" width = 200 height = 400>
                
### 我的_修改密码界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/modify_pass_page.jpg" width = 200 height = 400>
                
### 我的_绑定手机界面
<image src = "https://github.com/SunLongbri/work_station/blob/release/bind_phone_page.jpg" width = 200 height = 400>

