Config = {}
abdurhman = {}
Config.Locale = 'en'

Config.Accounts = {
	bank = _U('account_bank'),
	black_money = _U('account_black_money'),
	money = _U('account_money')
}

Config.StartingAccountMoney = {bank = 250000}

Config.EnableSocietyPayouts = false -- الدفع من حساب المجتمع الذي يعمل فيه اللاعب؟ المتطلبات: esx_society
Config.EnableHud            = false -- تمكين هود الافتراضي؟ عرض الوظيفة والحسابات الحالية (الأسود والبنوك والنقدية)
Config.MaxWeight            = 150   -- الحد الأقصى لوزن المخزون بدون حقيبة الظهر
Config.PaycheckInterval     = 7 * 60000 -- عدد المرات التي يتم فيها استلام شيكات الراتب بالمللي ثانية
Config.PaycheckXP = 15 -- كم خبرة ياخذ الشخص مع الراتب
Config.EnableDebug          = false

abdurhman.pas = 'KD2GA22d22WFFF%61FF555%@@!FFABF3^WJJ@AGA246ERJY4326WY' -- الباسورد غيره من فترة لفترة ولاتعطيه لأحد (غيره لأي شي عشوائي صعب)
abdurhman = {
	CanDropWeapons = false, -- هل يمكن للاعبين التخلص من الأسلحة بالأرض؟ -- لايوجد لوق للتخلص من الأسلحة
	MaxMoneyDrop = 5000, -- كم أعلى مبلغ يمكن التخلص منه بالأرض يمكن وضع رقم جدا كثير اذا ماتبي تفعلها
	---------------------
	---إعدادات الأنتظار---
	---------------------
	DropWaitTime = 10, -- مدة انتظار التخلص من شيء بالثواني
	giveItemORMoney_WaitTime = 5, -- مدة أنتظار أعطاء مال او ايتم بالثواني
	useItem_WaitTime = 5, -- مدة أنتظار أستخدام أيتم
}
