# CryptoWallet  

iOS: 15+  
Libraries: SnapKit  
Architecture: (MVP + Router) + Coordinator  

## Почему выбрал именно MVP?  
Проект очень маленький, и я не видел смысла реализовывать его на более «больших и сложных» архитектурах (например, VIPER или Clean Swift).  

### Структура проекта  

1. View – его роль берет на себя ViewController (удобнее, чем просто UIView, так как есть доступ к жизненному циклу).  
2. Presenter – «тупой» класс, который не знает ничего о View (закрыта протоколом). Он взаимодействует с бизнес-логикой (моделью) и вызывает экшены для перерисовки UI.  
3. Model – в этой роли выступает сетевой слой, который предоставляет интерфейс для получения данных с API.  
4. Router – объект, который делегирует логику навигации, освобождая View от этой ответственности. Также делегирует экшены на смену флоу, используя координатор.  
5. Coordinator – *в данном случае это, конечно, оверхед*, но, согласно ТЗ, необходимо было реализовать смену флоу с затрагиванием UIWindow. В крупных проектах это обычно делается через координатор, который отвечает за глобальную навигацию (смену флоу) и может вызывать дополнительные сайд-эффекты (например, выход из аккаунта).  

## Организация проекта  
Старался структурировать код по папкам и файлам, чтобы сделать проект удобным для работы.
