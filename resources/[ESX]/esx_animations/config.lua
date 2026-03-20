Config = {}

Config.MenuLanguage = 'ar'

Config.Animations = {
	
	{
		name  = 'mostused',
		label = '<font color=orange>🌟 الأكثر استعمال</font>',
		items = {
			-- {label = "Police salute", type = "dpemotes", data = {type='Emotes',name='salute'}},

			{label = "شرطي حارس", type = "dpemotes", data = {type='Emotes', name='cop'}},
			{label = "مرحبا", type = "dpemotes", data = {type = "Emotes", lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "نوتة", type = "dpemotes", data = {type='PropEmotes',name='notepad'}},
			{label = "لوح بيدك 4", type = "dpemotes", data = {type='Emotes',name='wave4'}},
			{label = "دفتر ملاحظات", type = "dpemotes", data = {type='PropEmotes',name='clipboard'}},
			{label = "استيقاف مركبة او شخص", type = "dpemotes", data = {type='Emotes',name='pullover'}},
			{label = "وضع يدك على الطاولة", type = "dpemotes", data = {type='Emotes',name='bartender'}},
			{label = "واقف مكانك", type = "dpemotes", data = {type='Emotes',name='idle'}},
			{label = "انتظار", type = "dpemotes", data = {type='Emotes',name='wait'}},
			{label = "ضم اليد", type = "dpemotes", data = {type='Emotes',name='crossarms'}},
			{label = "اجلس على الأرض", type = "dpemotes", data = {type='Emotes',name='sit'}},
			{label = "استند على الجدار", type = "dpemotes", data = {type='Emotes',name='lean'}},
			{label = "مرهق او تعبان", type = "dpemotes", data = {type='Emotes',name='chill'}},
			{label = "استلقاء على ظهرك", type = "dpemotes", data = {type='Emotes',name='cloudgaze'}},
			{label = "حقية عمل", type = "dpemotes", data = {type='PropEmotes',name='suitcase2'}},
			{label = "قهوة", type = "dpemotes", data = {type='PropEmotes',name='coffee'}},
			{label = "كوب", type = "dpemotes", data = {type='PropEmotes',name='cup'}},
			{label = "خريطة", type = "dpemotes", data = {type='PropEmotes',name='map'}},
			{label = "كاميرا", type = "dpemotes", data = {type='PropEmotes',name='camera'}},
			{label = "صور سلفي", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "نزل راسك", type = "dpemotes", data = {type='Emotes',name='fallasleep'}},
			{label = "صفق عادي", type = "dpemotes", data = {type='Emotes',name='clap'}},
			{label = "طرق الباب", type = "dpemotes", data = {type='Emotes',name='knock'}},
			{label = "تأشيرة توصيل للسيارات", type = "dpemotes", data = {type='Emotes',name='lift'}},
			{label = "ارفع يدك للتفتيش", type = "dpemotes", data = {type='Emotes',name='t'}},
			{label = "ارفع يدك للتفتيش 2", type = "dpemotes", data = {type='Emotes',name='t2'}},
		}
	},
	
	{
		name  = 'cop',
		label = '<font color=#0094FF>عسكرية</font>',
		items = {
			{label = "تحية عسكرية", type = "dpemotes", data = {type='Emotes',name='salute'}},
			--{label = "تحية عسكرية 2", type = "dpemotes", data = {type='Emotes',name='salute2'}},
			--{label = "تحية عسكرية 3", type = "dpemotes", data = {type='Emotes',name='salute3'}},
			{label = "شرطي حارس", type = "dpemotes", data = {type='Emotes',name='cop'}},
			{label = "شرطي حارس 2", type = "dpemotes", data = {type='Emotes',name='cop2'}},
			{label = "شرطي حارس 3", type = "dpemotes", data = {type='Emotes',name='cop3'}},
			{label = "التحدث على الراديو", type = "anim", data = {lib = "random@arrests", anim = "generic_radio_chatter"}},
			{label = "تنظيم مرور", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			{label = "الشرطة: بحث", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
		}
	},
	
	{
		name  = 'Shared',
		label = '<font color=#B200FF>👫 مشاركة مع لاعب</font>',
		items = {
			{label = "اصافحك", type = "dpemotes", data = {type='Shared',name='handshake'}},
			{label = "صافحني", type = "dpemotes", data = {type='Shared',name='handshake2'}},
			{label = "اعانقك", type = "dpemotes", data = {type='Shared',name='hug'}},
			{label = "عانقني", type = "dpemotes", data = {type='Shared',name='hug2'}},
			{label = "خوي", type = "dpemotes", data = {type='Shared',name='bro'}},
			{label = "خوي 2", type = "dpemotes", data = {type='Shared',name='bro2'}},
			{label = "عطاء", type = "dpemotes", data = {type='Shared',name='give'}},
			{label = "عطاء 2", type = "dpemotes", data = {type='Shared',name='give2'}},
			{label = "ارميلك كرة بيسبول", type = "dpemotes", data = {type='Shared',name='baseball'}},
			{label = "ارميلي كرة بيسبول", type = "dpemotes", data = {type='Shared',name='baseballthrow'}},
			{label = "اهددك", type = "dpemotes", data = {type='Shared',name='stickup'}},
			{label = "هددني", type = "dpemotes", data = {type='Shared',name='stickupscared'}},
			{label = "الكمك", type = "dpemotes", data = {type='Shared',name='punch'}},
			{label = "الكمني", type = "dpemotes", data = {type='Shared',name='punched'}},
			{label = "اضربك رأس", type = "dpemotes", data = {type='Shared',name='headbutt'}},
			{label = "اضربني رأس", type = "dpemotes", data = {type='Shared',name='headbutted'}},
			{label = "اصفعك", type = "dpemotes", data = {type='Shared',name='slap'}},
			{label = "اصفعك 2", type = "dpemotes", data = {type='Shared',name='slap2'}},
			{label = "اصفعني", type = "dpemotes", data = {type='Shared',name='slapped'}},
			{label = "اصفعني 2", type = "dpemotes", data = {type='Shared',name='slapped2'}}
		}
	},
	
	{
		name  = 'PropEmotes',
		label = '<font color=#FFD800>📦 مع رسباون شي</font>',
		items = {
			{label = "مظلة", type = "dpemotes", data = {type='PropEmotes',name='umbrella'}},
			{label = "نوتة", type = "dpemotes", data = {type='PropEmotes',name='notepad'}},
			{label = "صندوق", type = "dpemotes", data = {type='PropEmotes',name='box'}},
			{label = "وردة", type = "dpemotes", data = {type='PropEmotes',name='rose'}},
			--{label = "تحشيش", type = "dpemotes", data = {type='PropEmotes',name='bong'}},
			{label = "حقية سفر", type = "dpemotes", data = {type='PropEmotes',name='suitcase'}},
			{label = "حقية عمل", type = "dpemotes", data = {type='PropEmotes',name='suitcase2'}},
			{label = "تصوير متهم", type = "dpemotes", data = {type='PropEmotes',name='mugshot'}},
			{label = "قهوة", type = "dpemotes", data = {type='PropEmotes',name='coffee'}},
			{label = "ويسكي", type = "dpemotes", data = {type='PropEmotes',name='whiskey'}},
			{label = "بيرة", type = "dpemotes", data = {type='PropEmotes',name='beer'}},
			{label = "كوب", type = "dpemotes", data = {type='PropEmotes',name='cup'}},
			--{label = "دونتس", type = "dpemotes", data = {type='PropEmotes',name='donut'}},
			--{label = "برجر", type = "dpemotes", data = {type='PropEmotes',name='burger'}},
			--{label = "شطيرو", type = "dpemotes", data = {type='PropEmotes',name='sandwich'}},
			--{label = "كولا", type = "dpemotes", data = {type='PropEmotes',name='soda'}},
			--{label = "سناك", type = "dpemotes", data = {type='PropEmotes',name='egobar'}},
			{label = "نبيذ", type = "dpemotes", data = {type='PropEmotes',name='wine'}},
			{label = "flute", type = "dpemotes", data = {type='PropEmotes',name='flute'}},
			{label = "مشروب", type = "dpemotes", data = {type='PropEmotes',name='champagne'}},
			{label = "سيجار", type = "dpemotes", data = {type='PropEmotes',name='cigar'}},
			{label = "سيجار 2", type = "dpemotes", data = {type='PropEmotes',name='cigar2'}},
			{label = "قيتار", type = "dpemotes", data = {type='PropEmotes',name='guitar'}},
			{label = "قيتار 2", type = "dpemotes", data = {type='PropEmotes',name='guitar2'}},
			{label = "قيتار الكتروني", type = "dpemotes", data = {type='PropEmotes',name='guitarelectric'}},
			{label = "قيتار الكتروني 2", type = "dpemotes", data = {type='PropEmotes',name='guitarelectric 2'}},
			{label = "كتاب", type = "dpemotes", data = {type='PropEmotes',name='book'}},
			{label = "بوكيه ورد", type = "dpemotes", data = {type='PropEmotes',name='bouquet'}},
			{label = "دب تيدي", type = "dpemotes", data = {type='PropEmotes',name='teddy'}},
			{label = "حقيبة ظهر", type = "dpemotes", data = {type='PropEmotes',name='backpack'}},
			{label = "دفتر ملاحظات", type = "dpemotes", data = {type='PropEmotes',name='clipboard'}},
			{label = "خريطة", type = "dpemotes", data = {type='PropEmotes',name='map'}},
			{label = "استفزاز", type = "dpemotes", data = {type='PropEmotes',name='beg'}},
			--{label = "makeitrain", type = "dpemotes", data = {type='PropEmotes',name='makeitrain'}},
			{label = "كاميرا", type = "dpemotes", data = {type='PropEmotes',name='camera'}}
		}
	},
	
	{
		name  = 'scared',
		label = 'الخوف والاستسلام',
		items = {
			{label = "اجلس على الأرض خائف", type = "dpemotes", data = {type='Emotes',name='sitscared'}},
			{label = "اجلس على الأرض خائف 2", type = "dpemotes", data = {type='Emotes',name='sitscared2'}},
			{label = "اجلس على الأرض خائف 3", type = "dpemotes", data = {type='Emotes',name='sitscared3'}},
			{label = "خائف", type = "dpemotes", data = {type='Emotes',name='scared'}},
			{label = "خائف 2", type = "dpemotes", data = {type='Emotes',name='scared2'}},
			--{label = "اغمى عليه", type = "dpemotes", data = {type='Emotes',name='passout'}},
			--{label = "اغمى عليه 2", type = "dpemotes", data = {type='Emotes',name='passout2'}},
			--{label = "اغمى عليه 3", type = "dpemotes", data = {type='Emotes',name='passout3'}},
			--{label = "اغمى عليه 4", type = "dpemotes", data = {type='Emotes',name='passout4'}},
			{label = "خائف 3", type = "dpemotes", data = {type='Emotes',name='passout5'}},
			{label = "نزل راسك", type = "dpemotes", data = {type='Emotes',name='fallasleep'}},
			{label = "مصاب بطلق", type = "dpemotes", data = {type='Emotes',name='shot'}},
			--{label = "استسلام", type = "dpemotes", data = {type='Emotes',name='surrender'}},
			--{label = "انتحار", type = "dpemotes", data = {type='Emotes',name='fallover'}},
			--{label = "انتحار 2", type = "dpemotes", data = {type='Emotes',name='fallover2'}},
			--{label = "انتحار 3", type = "dpemotes", data = {type='Emotes',name='fallover3'}},
			--{label = "انتحار 4", type = "dpemotes", data = {type='Emotes',name='fallover4'}},
			--{label = "انتحار 5", type = "dpemotes", data = {type='Emotes',name='fallover5'}},
		}
	},
	
	{
		name  = 'Expressions',
		label = 'النفسية تعبير الوجه',
		items = {
			{label = "عصبي", type = "dpemotes", data = {type='Expressions',name='Angry'}},
			{label = "تعبان", type = "dpemotes", data = {type='Expressions',name='Dumb'}},
			{label = "غاضب", type = "dpemotes", data = {type='Expressions',name='Grumpy'}},
			{label = "غاضب 2", type = "dpemotes", data = {type='Expressions',name='Grumpy2'}},
			{label = "غاضب 3", type = "dpemotes", data = {type='Expressions',name='Grumpy3'}},
			{label = "فرحان", type = "dpemotes", data = {type='Expressions',name='Happy'}},
			{label = "مصاب", type = "dpemotes", data = {type='Expressions',name='Injured'}},
			{label = "بشوش", type = "dpemotes", data = {type='Expressions',name='Joyful'}},
			{label = "مبرطم", type = "dpemotes", data = {type='Expressions',name='Mouthbreather'}},
			{label = "لا ترمش", type = "dpemotes", data = {type='Expressions',name='Never Blink'}},
			{label = "عين وحدة", type = "dpemotes", data = {type='Expressions',name='One Eye'}},
			{label = "مصدوم", type = "dpemotes", data = {type='Expressions',name='Shocked'}},
			{label = "مصدوم 2", type = "dpemotes", data = {type='Expressions',name='Shocked2'}},
			{label = "نعسان", type = "dpemotes", data = {type='Expressions',name='Sleeping'}},
			{label = "نعسان 2", type = "dpemotes", data = {type='Expressions',name='Sleeping2'}},
			{label = "نعسان 3", type = "dpemotes", data = {type='Expressions',name='Sleeping3'}},
			{label = "متعجرف", type = "dpemotes", data = {type='Expressions',name='Smug'}},
			{label = "مهايطي", type = "dpemotes", data = {type='Expressions',name='Speculative'}},
			{label = "مضغوط", type = "dpemotes", data = {type='Expressions',name='Stressed'}},
			{label = "مكتأب", type = "dpemotes", data = {type='Expressions',name='Sulking'}},
			{label = "مو صاحي", type = "dpemotes", data = {type='Expressions',name='Weird'}},
			{label = "مو صاحي 2", type = "dpemotes", data = {type='Expressions',name='Weird2'}},
		}
	},
	
	{
		name  = 'Dances',
		label = '🕺 رقص',
		items = {
			{label = "انثى", type = "dpemotes", data = {type='Dances',name='dancef'}},
			{label = "انثى 2", type = "dpemotes", data = {type='Dances',name='dancef2'}},
			{label = "انثى 3", type = "dpemotes", data = {type='Dances',name='dancef3'}},
			{label = "انثى 4", type = "dpemotes", data = {type='Dances',name='dancef4'}},
			{label = "انثى 5", type = "dpemotes", data = {type='Dances',name='dancef5'}},
			{label = "انثى 6", type = "dpemotes", data = {type='Dances',name='dancef6'}},
			{label = "بطئ", type = "dpemotes", data = {type='Dances',name='danceslow'}},
			{label = "بطئ 2", type = "dpemotes", data = {type='Dances',name='danceslow2'}},
			{label = "بطئ 3", type = "dpemotes", data = {type='Dances',name='danceslow3'}},
			{label = "بطئ 4", type = "dpemotes", data = {type='Dances',name='danceslow4'}},
			{label = "عادي", type = "dpemotes", data = {type='Dances',name='dance'}},
			{label = "عادي 2", type = "dpemotes", data = {type='Dances',name='dance2'}},
			{label = "عادي 3", type = "dpemotes", data = {type='Dances',name='dance3'}},
			{label = "عادي 4", type = "dpemotes", data = {type='Dances',name='dance4'}},
			{label = "عادي 5", type = "dpemotes", data = {type='Dances',name='dance5'}},
			{label = "عادي 6", type = "dpemotes", data = {type='Dances',name='dance6'}},
			{label = "عادي 7", type = "dpemotes", data = {type='Dances',name='dance7'}},
			{label = "عادي 8", type = "dpemotes", data = {type='Dances',name='dance8'}},
			{label = "فوق", type = "dpemotes", data = {type='Dances',name='danceupper'}},
			{label = "فوق 2", type = "dpemotes", data = {type='Dances',name='danceupper2'}},
			{label = "خجول", type = "dpemotes", data = {type='Dances',name='danceshy'}},
			{label = "خجول 2", type = "dpemotes", data = {type='Dances',name='danceshy2'}},
			{label = "خجول 3", type = "dpemotes", data = {type='Dances',name='danceshy3'}},
			{label = "عبيط", type = "dpemotes", data = {type='Dances',name='dancesilly'}},
			{label = "عبيط 2", type = "dpemotes", data = {type='Dances',name='dancesilly2'}},
			{label = "عبيط 3", type = "dpemotes", data = {type='Dances',name='dancesilly3'}},
			{label = "عبيط 4", type = "dpemotes", data = {type='Dances',name='dancesilly4'}},
			{label = "عبيط 5", type = "dpemotes", data = {type='Dances',name='dancesilly5'}},
			{label = "عبيط 6", type = "dpemotes", data = {type='Dances',name='dancesilly6'}},
			{label = "عبيط 7", type = "dpemotes", data = {type='Dances',name='dancesilly7'}},
			{label = "عبيط 8", type = "dpemotes", data = {type='Dances',name='dancesilly8'}},
			{label = "عبيط 9", type = "dpemotes", data = {type='Dances',name='dancesilly9'}},
			{label = "تحت عصا", type = "dpemotes", data = {type='Dances',name='danceglowstick'}},
			{label = "تحت عصا 2", type = "dpemotes", data = {type='Dances',name='danceglowstick2'}},
			{label = "تحت عصا 3", type = "dpemotes", data = {type='Dances',name='danceglowstick3'}},
			{label = "حصان", type = "dpemotes", data = {type='Dances',name='dancehorse'}},
			{label = "حصان 2", type = "dpemotes", data = {type='Dances',name='dancehorse2'}},
			{label = "حصان 3", type = "dpemotes", data = {type='Dances',name='dancehorse3'}}
		}
	},
	
	{
		name  = 'Walks',
		label = 'طريقة المشي',
		items = {
			{label = "<font color=green>عادي</font>", type = "dpemotes", data = {type='Walks',name='Reset'}},
			{label = "غريب", type = "dpemotes", data = {type='Walks',name='Alien'}},
			{label = "مسلح", type = "dpemotes", data = {type='Walks',name='Armored'}},
			{label = "متكبر", type = "dpemotes", data = {type='Walks',name='Arrogant'}},
			{label = "شجاع", type = "dpemotes", data = {type='Walks',name='Brave'}},
			{label = "عملي", type = "dpemotes", data = {type='Walks',name='Casual'}},
			{label = "عملي 2", type = "dpemotes", data = {type='Walks',name='Casual2'}},
			{label = "عملي 3", type = "dpemotes", data = {type='Walks',name='Casual3'}},
			{label = "عملي 4", type = "dpemotes", data = {type='Walks',name='Casual4'}},
			{label = "عملي 5", type = "dpemotes", data = {type='Walks',name='Casual5'}},
			{label = "عملي 6", type = "dpemotes", data = {type='Walks',name='Casual6'}},
			{label = "كتكوت", type = "dpemotes", data = {type='Walks',name='Chichi'}},
			{label = "واثق من نفسه", type = "dpemotes", data = {type='Walks',name='Confident'}},
			{label = "عسكري", type = "dpemotes", data = {type='Walks',name='Cop'}},
			{label = "عسكري 2", type = "dpemotes", data = {type='Walks',name='Cop2'}},
			{label = "عسكري 3", type = "dpemotes", data = {type='Walks',name='Cop3'}},
			{label = "انثى", type = "dpemotes", data = {type='Walks',name='Femme'}},
			{label = "مولع", type = "dpemotes", data = {type='Walks',name='Fire'}},
			{label = "مولع 2", type = "dpemotes", data = {type='Walks',name='Fire2'}},
			{label = "مولع 3", type = "dpemotes", data = {type='Walks',name='Fire3'}},
			{label = "مرتاح", type = "dpemotes", data = {type='Walks',name='Flee'}},
			{label = "بلطجي", type = "dpemotes", data = {type='Walks',name='Gangster'}},
			{label = "بلطجي 2", type = "dpemotes", data = {type='Walks',name='Gangster2'}},
			{label = "بلطجي 3", type = "dpemotes", data = {type='Walks',name='Gangster3'}},
			{label = "بلطجي 4", type = "dpemotes", data = {type='Walks',name='Gangster4'}},
			{label = "بلطجي 5", type = "dpemotes", data = {type='Walks',name='Gangster5'}},
			{label = "عبيط", type = "dpemotes", data = {type='Walks',name='Grooving'}},
			{label = "حارس", type = "dpemotes", data = {type='Walks',name='Guard'}},
			{label = "مقيد", type = "dpemotes", data = {type='Walks',name='Handcuffs'}},
			{label = "كعب", type = "dpemotes", data = {type='Walks',name='Heels'}},
			{label = "كعب 2", type = "dpemotes", data = {type='Walks',name='Heels'}},
			{label = "تكسر", type = "dpemotes", data = {type='Walks',name='Hipster'}},
			{label = "مشرد", type = "dpemotes", data = {type='Walks',name='Hobo'}},
			{label = "مستعجل", type = "dpemotes", data = {type='Walks',name='Hurry'}},
			{label = "بواب", type = "dpemotes", data = {type='Walks',name='Janitor'}},
			{label = "بواب 2", type = "dpemotes", data = {type='Walks',name='Janitor'}},
			{label = "جري بطيء", type = "dpemotes", data = {type='Walks',name='Jog'}},
			{label = "مطنوخ", type = "dpemotes", data = {type='Walks',name='Money'}},
			{label = "فخامة", type = "dpemotes", data = {type='Walks',name='Posh'}},
			{label = "فخامة 2", type = "dpemotes", data = {type='Walks',name='Posh2'}},
			{label = "سريع", type = "dpemotes", data = {type='Walks',name='Quick'}},
			{label = "جري", type = "dpemotes", data = {type='Walks',name='Runner'}},
			{label = "حزين", type = "dpemotes", data = {type='Walks',name='Sad'}},
			{label = "بقيح", type = "dpemotes", data = {type='Walks',name='Sassy'}},
			{label = "بقيح 2", type = "dpemotes", data = {type='Walks',name='Sassy2'}},
			{label = "خائف", type = "dpemotes", data = {type='Walks',name='Scared'}},
			{label = "جذاب", type = "dpemotes", data = {type='Walks',name='Sexy'}},
			{label = "متكبر", type = "dpemotes", data = {type='Walks',name='Shady'}},
			{label = "بطيء", type = "dpemotes", data = {type='Walks',name='Slow'}},
			{label = "Swagger", type = "dpemotes", data = {type='Walks',name='Swagger'}},
			{label = "معضل", type = "dpemotes", data = {type='Walks',name='Tough'}},
			{label = "معضل 2", type = "dpemotes", data = {type='Walks',name='Tough2'}},
			{label = "زبال", type = "dpemotes", data = {type='Walks',name='Trash'}},
			{label = "زبال 2", type = "dpemotes", data = {type='Walks',name='Trash2'}},
			{label = "سمين", type = "dpemotes", data = {type='Walks',name='Wide'}},
			{label = "شحصية فرانك", type = "dpemotes", data = {type='Walks',name='Franklin'}},
			{label = "شخصية مايكل", type = "dpemotes", data = {type='Walks',name='Michael'}},
			{label = "شخصية ترفر", type = "dpemotes", data = {type='Walks',name='Trevor'}},
			{label = "شخصية لمار", type = "dpemotes", data = {type='Walks',name='Lemar'}},
			{label = "شحصية لاستر", type = "dpemotes", data = {type='Walks',name='Lester'}},
			{label = "شخصية لاستر 2", type = "dpemotes", data = {type='Walks',name='Lester2'}},
			{label = "شخصية مانتر", type = "dpemotes", data = {type='Walks',name='Maneater'}},
		}
	},
	
	{
		name  = 'festives',
		label = 'احتفال',
		items = {
			{label = "تدخين سيجارة", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			--{label = "عزف موسيقى", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "رقص", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "اشرب بربيكان", type = "scenario", data = {anim = "WORLD_HUMAN_DRINKING"}},
			{label = "احتفال مشروب", type = "scenario", data = {anim = "WORLD_HUMAN_PARTYING"}},
			{label = "تمثيل قيتار", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			--{label = "شيله", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "روك", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			-- {label = "Fumer un joint", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING_POT"}},
			--{label = "سكران", type = "anim", data = {lib = "amb@world_human_bum_standing@drunk@idle_a", anim = "idle_a"}},
			{label = "استفراغ", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'الترحيب والمصافحة',
		items = {
			{label = "مرحبا", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "دغدغه", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "مصافحة", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "عناق", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			--{label = "تحية عسكرية", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}}, --يد يسار
			{label = "تحية عسكرية", type = "dpemotes", data = {type='Emotes',name='salute'}},
			{label = "لوح بيدك", type = "dpemotes", data = {type='Emotes',name='wave'}},
			{label = "لوح بيدك 2", type = "dpemotes", data = {type='Emotes',name='wave2'}},
			{label = "لوح بيدك 3", type = "dpemotes", data = {type='Emotes',name='wave3'}},
			{label = "لوح بيدك 4", type = "dpemotes", data = {type='Emotes',name='wave4'}},
			{label = "لوح بيدك 5", type = "dpemotes", data = {type='Emotes',name='wave5'}},
			{label = "لوح بيدك 6", type = "dpemotes", data = {type='Emotes',name='wave6'}},
			{label = "لوح بيدك 7", type = "dpemotes", data = {type='Emotes',name='wave7'}},
			{label = "لوح بيدك 8", type = "dpemotes", data = {type='Emotes',name='wave8'}},
			{label = "لوح بيدك 9", type = "dpemotes", data = {type='Emotes',name='wave9'}},
			{label = "عناق", type = "dpemotes", data = {type='Emotes',name='hug'}},
			{label = "عناق 2", type = "dpemotes", data = {type='Emotes',name='hug2'}},
			{label = "عناق 3", type = "dpemotes", data = {type='Emotes',name='hug3'}},
			{label = "مصافحة", type = "dpemotes", data = {type='Emotes',name='handshake'}},
			{label = "مصافحة 2", type = "dpemotes", data = {type='Emotes',name='handshake2'}},
		}
	},

	{
		name  = 'work',
		label = 'العمل',
		items = {
			--{label = "صياد سمك", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "الشرطة: بحث", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "الشرطة: تنظيم مرور", type = "scenario", data = {anim = "WORLD_HUMAN_CAR_PARK_ATTENDANT"}},
			--{label = "الشرطة: المراقبة", type = "scenario", data = {anim = "WORLD_HUMAN_BINOCULARS"}},
			{label = "الزراعة: حصاد", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			--{label = "ميكانيكي: اصلاح تحت السيارة", type = "scenario", data = {anim = "world_human_vehicle_mechanic"}},
			{label = "ميكانيكي: اصلاح المحرك", type = "anim", data = {lib = "mini@repair", anim = "fixing_a_ped"}},
			{label = "اسعاف: تشخيص المريض", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			--{label = "تاكسي: التحدث مع الزبون", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
			--{label = "تاكسي: اعطي الفاتورة", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
			{label = "بقال: المناولة", type = "anim", data = {lib = "mp_am_hold_up", anim = "purchase_beerbox_shopkeeper"}},
			{label = "النادل: تحضير مشروب", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			{label = "المراسل: التقاط صورة", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
			{label = "اعمال حرة: كتابة ملاحظات", type = "scenario", data = {anim = "WORLD_HUMAN_CLIPBOARD"}},
			{label = "اعمال حرة: ضرب بالمطرقة", type = "scenario", data = {anim = "WORLD_HUMAN_HAMMERING"}},
			{label = "ميكانيك", type = "dpemotes", data = {type='Emotes',name='mechanic'}},
			{label = "ميكانيك 2", type = "dpemotes", data = {type='Emotes',name='mechanic2'}},
			{label = "ميكانيك 3", type = "dpemotes", data = {type='Emotes',name='mechanic3'}},
			{label = "ميكانيك 4", type = "dpemotes", data = {type='Emotes',name='mechanic4'}},
			{label = "مسعف", type = "dpemotes", data = {type='Emotes',name='medic'}},
			{label = "مسعف 2", type = "dpemotes", data = {type='Emotes',name='medic2'}},
			{label = "كتابة كيبورد", type = "dpemotes", data = {type='Emotes',name='type'}},
			{label = "كتابة كيبورد 2", type = "dpemotes", data = {type='Emotes',name='type2'}},
			{label = "كتابة كيبورد 3", type = "dpemotes", data = {type='Emotes',name='type3'}},
			{label = "كتابة كيبورد 4", type = "dpemotes", data = {type='Emotes',name='type4'}},
			--{label = "شحات", type = "scenario", data = {anim = "WORLD_HUMAN_BUM_FREEWAY"}},
			--{label = "Clochard : Faire la statue", type = "scenario", data = {anim = "WORLD_HUMAN_HUMAN_STATUE"}},
		}
	},

	{
		name  = 'humors',
		label = 'المزاجية والتعبير',
		items = {
			--{label = "تصفيق", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "سمبتيك", type = "dpemotes", data = {type='Emotes',name='ok'}},
			{label = "لا", type = "dpemotes", data = {type='Emotes',name='no'}},
			{label = "لا 2", type = "dpemotes", data = {type='Emotes',name='no2'}},
			{label = "مستحيل", type = "dpemotes", data = {type='Emotes',name='noway'}},
			{label = "صفق عادي", type = "dpemotes", data = {type='Emotes',name='clap'}},
			{label = "صفق بأعصاب", type = "dpemotes", data = {type='Emotes',name='clapangry'}},
			{label = "صفق بطيء", type = "dpemotes", data = {type='Emotes',name='slowclap'}},
			{label = "صفق بطيء 2", type = "dpemotes", data = {type='Emotes',name='slowclap2'}},
			{label = "صفق بطيء 3", type = "dpemotes", data = {type='Emotes',name='slowclap3'}},
			{label = "احسنت", type = "anim", data = {lib = "mp_action", anim = "thanks_male_06"}},
			{label = "أنت", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "اقلب وجهك", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "شفيك؟", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_bring_it_on"}},
			{label = "أنا", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "كنت أعرف ذلك، سخيف", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			--{label = "Etre épuisé", type = "scenario", data = {lib = "amb@world_human_jog_standing@male@idle_b", anim = "idle_d"}},
			--{label = "أنا متعب", type = "scenario", data = {lib = "amb@world_human_bum_standing@depressed@idle_a", anim = "idle_a"}},
			{label = "ضرب الوجه", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "اهدأ ", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "ماذا فعلت أنا ؟", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "خائف", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "فرقع ظهرك", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "مستحيل", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			{label = "تقبيل", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "انتحار", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
			{label = "فكر", type = "dpemotes", data = {type='Emotes',name='think'}},
			{label = "فكر 2", type = "dpemotes", data = {type='Emotes',name='think2'}},
			{label = "فكر 3", type = "dpemotes", data = {type='Emotes',name='think3'}},
			{label = "فكر 4", type = "dpemotes", data = {type='Emotes',name='think4'}},
			{label = "فكر 5", type = "dpemotes", data = {type='Emotes',name='think5'}},
			{label = "استحسان", type = "dpemotes", data = {type='Emotes',name='thumbsup'}},
			{label = "استحسان 2", type = "dpemotes", data = {type='Emotes',name='thumbsup2'}},
			{label = "استحسان 3", type = "dpemotes", data = {type='Emotes',name='thumbsup3'}},
			{label = "ضرب الوجه", type = "dpemotes", data = {type='Emotes',name='facepalm'}},
			{label = "ضرب الوجه 2", type = "dpemotes", data = {type='Emotes',name='facepalm2'}},
			{label = "ضرب الوجه 3", type = "dpemotes", data = {type='Emotes',name='facepalm3'}},
			{label = "ضرب الوجه 4", type = "dpemotes", data = {type='Emotes',name='facepalm4'}},
			{label = "تأشير", type = "dpemotes", data = {type='Emotes',name='point'}},
			{label = "تأشير 2", type = "dpemotes", data = {type='Emotes',name='pointright'}},
			{label = "نظف ملابسك", type = "dpemotes", data = {type='Emotes',name='shakeoff'}},
			{label = "مصاب بطلق", type = "dpemotes", data = {type='Emotes',name='shot'}},
			{label = "هز كتفة", type = "dpemotes", data = {type='Emotes',name='shrug'}},
			{label = "هز كتفة 2", type = "dpemotes", data = {type='Emotes',name='shrug2'}},
			{label = "شم ريحة يدك", type = "dpemotes", data = {type='Emotes',name='smell'}},
			{label = "تمثيل تهديد سلاح", type = "dpemotes", data = {type='Emotes',name='stickup'}},
			{label = "تمثيل اصابة بالرأس", type = "dpemotes", data = {type='Emotes',name='stumble'}},
			{label = "تجادل", type = "dpemotes", data = {type='Emotes',name='argue'}},
			{label = "تجادل 2", type = "dpemotes", data = {type='Emotes',name='argue2'}},
			{label = "وضع يدك على الطاولة", type = "dpemotes", data = {type='Emotes',name='bartender'}},
			{label = "تباً", type = "dpemotes", data = {type='Emotes',name='damn'}},
			{label = "تباً 2", type = "dpemotes", data = {type='Emotes',name='damn2'}},
			{label = "اشر تحت", type = "dpemotes", data = {type='Emotes',name='pointdown'}},
		}
	},

	{
		name  = 'sports',
		label = 'الرياضة',
		items = {
			{label = "استعراض عضلات", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "رفع اثقال", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "تمرين ضغط", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			--{label = "تمرين معدة", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "معدة", type = "dpemotes", data = {type='Emotes',name='situp'}},
			{label = "تمرين يوقا", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
			{label = "يوقا 2", type = "dpemotes", data = {type='Emotes',name='meditate'}},
			{label = "يوقا 3", type = "dpemotes", data = {type='Emotes',name='meditate2'}},
			{label = "يوقا 4", type = "dpemotes", data = {type='Emotes',name='meditate3'}},
			{label = "هرولة", type = "dpemotes", data = {type='Emotes',name='jog'}},
			{label = "هرولة 2", type = "dpemotes", data = {type='Emotes',name='jog2'}},
			{label = "هرولة 3", type = "dpemotes", data = {type='Emotes',name='jog3'}},
			{label = "هرولة 4", type = "dpemotes", data = {type='Emotes',name='jog4'}},
			{label = "هرولة 5", type = "dpemotes", data = {type='Emotes',name='jog5'}},
			{label = "يلهث", type = "dpemotes", data = {type='Emotes',name='outofbreath'}},
			{label = "ضغط", type = "dpemotes", data = {type='Emotes',name='pushup'}},
			{label = "عد تنازلي", type = "dpemotes", data = {type='Emotes',name='countdown'}},
			{label = "قفز", type = "dpemotes", data = {type='Emotes',name='jumpingjacks'}},
		}
	},

	{
		name  = 'lead',
		label = 'انتظار والجلوس وضم اليد',
		items = {
			{label = "اجلس على الكرسي", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
			--{label = "انتظر على الجدار", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "انحناء", type = "dpemotes", data = {type='Emotes',name='lean'}},
			{label = "انحناء 2", type = "dpemotes", data = {type='Emotes',name='lean2'}},
			{label = "انحناء 3", type = "dpemotes", data = {type='Emotes',name='lean3'}},
			{label = "انحناء 4", type = "dpemotes", data = {type='Emotes',name='lean4'}},
			{label = "انحناء 5", type = "dpemotes", data = {type='Emotes',name='lean5'}},
			--{label = "انحناء معاكسة", type = "dpemotes", data = {type='Emotes',name='leanflirt'}},
			--{label = "انحناء معاكسة 2", type = "dpemotes", data = {type='Emotes',name='leanflirt2'}},
			{label = "انحناء بار", type = "dpemotes", data = {type='Emotes',name='leanbar'}},
			{label = "انحناء بار 2", type = "dpemotes", data = {type='Emotes',name='leanbar2'}},
			{label = "انحناء بار 3", type = "dpemotes", data = {type='Emotes',name='leanbar3'}},
			{label = "انحناء بار 4", type = "dpemotes", data = {type='Emotes',name='leanbar4'}},
			{label = "انحناء عالي", type = "dpemotes", data = {type='Emotes',name='leanhigh'}},
			{label = "انحناء عالي 2", type = "dpemotes", data = {type='Emotes',name='leanhigh2'}},
			{label = "انحناء عالي 3", type = "dpemotes", data = {type='Emotes',name='leanhigh3'}},
			{label = " انحاء جنب", type = "dpemotes", data = {type='Emotes',name='leanside'}},
			{label = " انحاء جنب 2", type = "dpemotes", data = {type='Emotes',name='leanside2'}},
			{label = " انحاء جنب 3", type = "dpemotes", data = {type='Emotes',name='leanside3'}},
			{label = " انحاء جنب 4", type = "dpemotes", data = {type='Emotes',name='leanside4'}},
			{label = " انحاء جنب 5", type = "dpemotes", data = {type='Emotes',name='leanside5'}},
			{label = "تأمل", type = "dpemotes", data = {type='Emotes',name='meditate'}},
			{label = "تأمل 2", type = "dpemotes", data = {type='Emotes',name='meditate2'}},
			{label = "تأمل 3", type = "dpemotes", data = {type='Emotes',name='meditate3'}},
			{label = "اجلس على الأرض", type = "dpemotes", data = {type='Emotes',name='sit'}},
			{label = "اجلس على الأرض 2", type = "dpemotes", data = {type='Emotes',name='sit2'}},
			{label = "اجلس على الأرض 3", type = "dpemotes", data = {type='Emotes',name='sit3'}},
			{label = "اجلس على الأرض 4", type = "dpemotes", data = {type='Emotes',name='sit4'}},
			{label = "اجلس على الأرض 5", type = "dpemotes", data = {type='Emotes',name='sit5'}},
			{label = "اجلس على الأرض 6", type = "dpemotes", data = {type='Emotes',name='sit6'}},
			{label = "اجلس على الأرض 7", type = "dpemotes", data = {type='Emotes',name='sit7'}},
			{label = "اجلس على الأرض 8", type = "dpemotes", data = {type='Emotes',name='sit8'}},
			{label = "اجلس على الأرض 9", type = "dpemotes", data = {type='Emotes',name='sit9'}},
			{label = "اجلس على الأرض منحني", type = "dpemotes", data = {type='Emotes',name='sitlean'}},
			{label = "اجلس على الأرض حزين", type = "dpemotes", data = {type='Emotes',name='sitsad'}},
			{label = "اجلس على الأرض خائف", type = "dpemotes", data = {type='Emotes',name='sitscared'}},
			{label = "اجلس على الأرض خائف 2", type = "dpemotes", data = {type='Emotes',name='sitscared2'}},
			{label = "اجلس على الأرض خائف 3", type = "dpemotes", data = {type='Emotes',name='sitscared3'}},
			{label = "اجلس على الأرض سكران", type = "dpemotes", data = {type='Emotes',name='sitdrunk'}},
			{label = "اجلس مقعد", type = "dpemotes", data = {type='Emotes',name='sitchair'}},
			{label = "اجلس مقعد 2", type = "dpemotes", data = {type='Emotes',name='sitchair2'}},
			{label = "اجلس مقعد 3", type = "dpemotes", data = {type='Emotes',name='sitchair3'}},
			{label = "اجلس مقعد 4", type = "dpemotes", data = {type='Emotes',name='sitchair4'}},
			{label = "اجلس مقعد 5", type = "dpemotes", data = {type='Emotes',name='sitchair5'}},
			{label = "اجلس مقعد 6", type = "dpemotes", data = {type='Emotes',name='sitchair6'}},
			{label = "واقف مكانك", type = "dpemotes", data = {type='Emotes',name='idle'}},
			{label = "واقف مكانك 2", type = "dpemotes", data = {type='Emotes',name='idle2'}},
			{label = "واقف مكانك 3", type = "dpemotes", data = {type='Emotes',name='idle3'}},
			{label = "واقف مكانك 4", type = "dpemotes", data = {type='Emotes',name='idle4'}},
			{label = "واقف مكانك 5", type = "dpemotes", data = {type='Emotes',name='idle5'}},
			{label = "واقف مكانك 6", type = "dpemotes", data = {type='Emotes',name='idle6'}},
			{label = "واقف مكانك 7", type = "dpemotes", data = {type='Emotes',name='idle7'}},
			{label = "واقف مكانك 8", type = "dpemotes", data = {type='Emotes',name='idle8'}},
			{label = "واقف مكانك 9", type = "dpemotes", data = {type='Emotes',name='idle9'}},
			{label = "واقف مكانك 10", type = "dpemotes", data = {type='Emotes',name='idle10'}},
			{label = "واقف مكانك 11", type = "dpemotes", data = {type='Emotes',name='idle11'}},
			{label = "انتظار", type = "dpemotes", data = {type='Emotes',name='wait'}},
			{label = "انتظار 2", type = "dpemotes", data = {type='Emotes',name='wait2'}},
			{label = "انتظار 3", type = "dpemotes", data = {type='Emotes',name='wait3'}},
			{label = "انتظار 4", type = "dpemotes", data = {type='Emotes',name='wait4'}},
			{label = "انتظار 5", type = "dpemotes", data = {type='Emotes',name='wait5'}},
			{label = "انتظار 6", type = "dpemotes", data = {type='Emotes',name='wait6'}},
			{label = "انتظار 7", type = "dpemotes", data = {type='Emotes',name='wait7'}},
			{label = "انتظار 8", type = "dpemotes", data = {type='Emotes',name='wait8'}},
			{label = "انتظار 9", type = "dpemotes", data = {type='Emotes',name='wait9'}},
			{label = "انتظار 10", type = "dpemotes", data = {type='Emotes',name='wait10'}},
			{label = "انتظار 11", type = "dpemotes", data = {type='Emotes',name='wait11'}},
			{label = "ضم اليد", type = "dpemotes", data = {type='Emotes',name='crossarms'}},
			{label = "ضم اليد 2", type = "dpemotes", data = {type='Emotes',name='crossarms2'}},
			{label = "ضم اليد 3", type = "dpemotes", data = {type='Emotes',name='crossarms3'}},
			{label = "ضم اليد 4", type = "dpemotes", data = {type='Emotes',name='crossarms4'}},
			{label = "ضم اليد 6", type = "dpemotes", data = {type='Emotes',name='crossarms5'}},
			{label = "ضم اليد 7", type = "dpemotes", data = {type='Emotes',name='foldarms'}},
			{label = "ضم اليد 8", type = "dpemotes", data = {type='Emotes',name='foldarms2'}},
		}
	},

	{
		name  = 'kabali',
		label = 'استهزاء واستفزاز',
		items = {
			{label = "استهزاء ارسل قبلة", type = "dpemotes", data = {type='Emotes',name='blowkiss'}},
			{label = "استهزاء ارسل قبلة 2", type = "dpemotes", data = {type='Emotes',name='blowkiss2'}},
			{label = "استهزاء خوفتني", type = "dpemotes", data = {type='Emotes',name='curtsy'}},
			{label = "استهزاء ضم اليد", type = "dpemotes", data = {type='Emotes',name='crossarmsside'}},
			{label = "استهزاء تعال", type = "dpemotes", data = {type='Emotes',name='bringiton'}},
			{label = "استهزاء تعال 2", type = "dpemotes", data = {type='Emotes',name='comeatmebro'}},
			{label = " قيتار هوائي", type = "dpemotes", data = {type='Emotes',name='airguitar'}},
			{label = "موسيقى الجاز", type = "dpemotes", data = {type='Emotes',name='jazzhands'}},
			{label = "استفزاز", type = "dpemotes", data = {type='Emotes',name='airsynth'}},
			{label = "وحش", type = "dpemotes", data = {type='Emotes',name='beast'}},
			{label = "تضارب معي", type = "dpemotes", data = {type='Emotes',name='fightme'}},
			{label = "تضارب معي", type = "dpemotes", data = {type='Emotes',name='fightme2'}},
			{label = "فرقع اصابعك", type = "dpemotes", data = {type='Emotes',name='knucklecrunch'}},
			{label = "اغراء", type = "dpemotes", data = {type='Emotes',name='lapdance'}},
			{label = "طرق الباب", type = "dpemotes", data = {type='Emotes',name='knock'}},
			{label = "طرق الباب 2", type = "dpemotes", data = {type='Emotes',name='knock2'}},
			{label = "أنا", type = "dpemotes", data = {type='Emotes',name='me'}},
			{label = "حركة اصابع", type = "dpemotes", data = {type='Emotes',name='metal'}},
			{label = "نظف انفك", type = "dpemotes", data = {type='Emotes',name='nosepick'}},
			{label = "نظف ملابسك", type = "dpemotes", data = {type='Emotes',name='shakeoff'}},
			{label = "شم ريحة يدك", type = "dpemotes", data = {type='Emotes',name='smell'}},
			{label = "تكهرب", type = "dpemotes", data = {type='Emotes',name='stunned'}},
			{label = "صفر", type = "dpemotes", data = {type='Emotes',name='whistle'}},
			{label = "صفر 2", type = "dpemotes", data = {type='Emotes',name='whistle2'}},
			{label = "يب", type = "dpemotes", data = {type='Emotes',name='yeah'}},
			{label = "لول", type = "dpemotes", data = {type='Emotes',name='lol'}},
			{label = "تمثال", type = "dpemotes", data = {type='Emotes',name='statue'}},
			{label = "تمثال 2", type = "dpemotes", data = {type='Emotes',name='statue2'}},
			{label = "تمثال 3", type = "dpemotes", data = {type='Emotes',name='statue3'}},
			{label = "حركة عصابات", type = "dpemotes", data = {type='Emotes',name='gangsign'}},
			{label = "حركة عصابات 2", type = "dpemotes", data = {type='Emotes',name='gangsign2'}},
			
		}
	},

	{
		name  = 'misc',
		label = 'آخر',
		items = {
			--{label = "شرب قهوة", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
			--{label = "اجلس على الارض", type = "scenario", data = {anim = "WORLD_HUMAN_PICNIC"}},
			{label = "الاستلقاء على الظهر", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "الاستلقاء على البطن", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			--{label = "تنظيف شيء", type = "scenario", data = {anim = "world_human_maid_clean"}},
			--{label = "تحضير اكل", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "ارفع يدك للتفتيش", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_bj_to_prop_female"}},
			{label = "صور سلفي", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "تنصت", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},
	
	{
		name  = 'Emotes',
		label = 'حركات اخرى جديدة',
		items = {
			--{label = "شرب", type = "dpemotes", data = {type='Emotes',name='drink'}},
			{label = "مرهق او تعبان", type = "dpemotes", data = {type='Emotes',name='chill'}},
			{label = "استلقاء على ظهرك", type = "dpemotes", data = {type='Emotes',name='cloudgaze'}},
			{label = "استلقاء على ظهرك", type = "dpemotes", data = {type='Emotes',name='cloudgaze2'}},
			{label = "استلقاء على بطنك", type = "dpemotes", data = {type='Emotes',name='prone'}},
			{label = "استيقاف مركبة او شخص", type = "dpemotes", data = {type='Emotes',name='pullover'}},
			--{label = "واقف مكانك سكران", type = "dpemotes", data = {type='Emotes',name='idledrunk'}},
			--{label = "واقف مكانك سكران 2", type = "dpemotes", data = {type='Emotes',name='idledrunk2'}},
			--{label = "واقف مكانك سكران 3", type = "dpemotes", data = {type='Emotes',name='idledrunk3'}},
			{label = "تسلق جبل", type = "dpemotes", data = {type='Emotes',name='hiking'}},
			{label = "معاينة وفحص", type = "dpemotes", data = {type='Emotes',name='inspect'}},
			{label = "ركوع", type = "dpemotes", data = {type='Emotes',name='kneel'}},
			{label = "ركوع 2", type = "dpemotes", data = {type='Emotes',name='kneel2'}},
			{label = "ركوع 3", type = "dpemotes", data = {type='Emotes',name='kneel3'}},
			{label = "ارفع شي من الارض", type = "dpemotes", data = {type='Emotes',name='pickup'}},
			{label = "ادفع", type = "dpemotes", data = {type='Emotes',name='push'}},
			{label = "ادفع", type = "dpemotes", data = {type='Emotes',name='push2'}},
			--{label = "تبا لك", type = "dpemotes", data = {type='Emotes',name='screwyou'}},
			{label = "نام", type = "dpemotes", data = {type='Emotes',name='sleep'}},
			{label = "شم ريحة يدك", type = "dpemotes", data = {type='Emotes',name='smell'}},
			{label = "تشمس", type = "dpemotes", data = {type='Emotes',name='sunbathe'}},
			{label = "تشمس 2", type = "dpemotes", data = {type='Emotes',name='sunbathe2'}},
			{label = "دفء", type = "dpemotes", data = {type='Emotes',name='warmth'}},
		}
	},
	
	--[[{
		name  = 'attitudem',
		label = 'طريقة المشي والشخصية',
		items = {
	    {label = "عادي / ذكر", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
	    {label = "مشرد / ذكر", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},	    
		{label = "متسرع / ذكر", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
	    {label = "تاجر", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
	    {label = "عنيد", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
	    {label = "زقرتي", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
	    {label = "سمين", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
	    {label = "حبوب", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
	    {label = "مصاب", type = "attitude", data = {lib = "move_m@injured", anim = "move_m@injured"}},
	    {label = "متكبر", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
	    {label = "محشش", type = "attitude", data = {lib = "move_m@hobo@a", anim = "move_m@hobo@a"}},
	    {label = "صنم", type = "attitude", data = {lib = "move_m@sad@a", anim = "move_m@sad@a"}},
	    {label = "معضل", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
	    {label = "قوي", type = "attitude", data = {lib = "move_m@shocked@a", anim = "move_m@shocked@a"}},
	    {label = "مغرور", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
	    {label = "متعب", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
	    {label = "مستعجل", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
	    {label = "متفاخر", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
		{label = "عادي / انثى", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
		{label = "مشرد / انثى", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
	    {label = "عرض ازياء / انثى", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
	    {label = "متسرع / انثى", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
	    {label = "مغرور / انثى", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	}, ]]
	
	--[[{
		name  = 'porn',
		label = 'PEGI 21',
		items = {
	    {label = "Homme se faire su*** en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
	    {label = "Femme faire une gaterie en voiture", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
	    {label = "Homme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
	    {label = "Femme bais** en voiture", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
	    {label = "Se gratter les couilles", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
	    {label = "Faire du charme", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
	    {label = "Pose michto", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
	    {label = "Montrer sa poitrine", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
	    {label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
	    {label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
	    {label = "Stip Tease au sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
      {label = "Finger of honor", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
      {label = "Branleur", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
			}
	},]]

}

--dpemotes configs

DP = {}

DP.Expressions = {
   ["Angry"] = {"Expression", "mood_angry_1"},
   ["Drunk"] = {"Expression", "mood_drunk_1"},
   ["Dumb"] = {"Expression", "pose_injured_1"},
   ["Electrocuted"] = {"Expression", "electrocuted_1"},
   ["Grumpy"] = {"Expression", "effort_1"},
   ["Grumpy2"] = {"Expression", "mood_drivefast_1"},
   ["Grumpy3"] = {"Expression", "pose_angry_1"},
   ["Happy"] = {"Expression", "mood_happy_1"},
   ["Injured"] = {"Expression", "mood_injured_1"},
   ["Joyful"] = {"Expression", "mood_dancing_low_1"},
   ["Mouthbreather"] = {"Expression", "smoking_hold_1"},
   ["Never Blink"] = {"Expression", "pose_normal_1"},
   ["One Eye"] = {"Expression", "pose_aiming_1"},
   ["Shocked"] = {"Expression", "shocked_1"},
   ["Shocked2"] = {"Expression", "shocked_2"},
   ["Sleeping"] = {"Expression", "mood_sleeping_1"},
   ["Sleeping2"] = {"Expression", "dead_1"},
   ["Sleeping3"] = {"Expression", "dead_2"},
   ["Smug"] = {"Expression", "mood_smug_1"},
   ["Speculative"] = {"Expression", "mood_aiming_1"},
   ["Stressed"] = {"Expression", "mood_stressed_1"},
   ["Sulking"] = {"Expression", "mood_sulk_1"},
   ["Weird"] = {"Expression", "effort_2"},
   ["Weird2"] = {"Expression", "effort_3"},
}

DP.Walks = {
  ["Alien"] = {"move_m@alien"},
  ["Armored"] = {"anim_group_move_ballistic"},
  ["Arrogant"] = {"move_f@arrogant@a"},
  ["Brave"] = {"move_m@brave"},
  ["Casual"] = {"move_m@casual@a"},
  ["Casual2"] = {"move_m@casual@b"},
  ["Casual3"] = {"move_m@casual@c"},
  ["Casual4"] = {"move_m@casual@d"},
  ["Casual5"] = {"move_m@casual@e"},
  ["Casual6"] = {"move_m@casual@f"},
  ["Chichi"] = {"move_f@chichi"},
  ["Confident"] = {"move_m@confident"},
  ["Cop"] = {"move_m@business@a"},
  ["Cop2"] = {"move_m@business@b"},
  ["Cop3"] = {"move_m@business@c"},
  ["Drunk"] = {"move_m@drunk@a"},
  ["Drunk"] = {"move_m@drunk@slightlydrunk"},
  ["Drunk2"] = {"move_m@buzzed"},
  ["Drunk3"] = {"move_m@drunk@verydrunk"},
  ["Femme"] = {"move_f@femme@"},
  ["Fire"] = {"move_characters@franklin@fire"},
  ["Fire2"] = {"move_characters@michael@fire"},
  ["Fire3"] = {"move_m@fire"},
  ["Flee"] = {"move_f@flee@a"},
  ["Franklin"] = {"move_p_m_one"},
  ["Gangster"] = {"move_m@gangster@generic"},
  ["Gangster2"] = {"move_m@gangster@ng"},
  ["Gangster3"] = {"move_m@gangster@var_e"},
  ["Gangster4"] = {"move_m@gangster@var_f"},
  ["Gangster5"] = {"move_m@gangster@var_i"},
  ["Grooving"] = {"anim@move_m@grooving@"},
  ["Guard"] = {"move_m@prison_gaurd"},
  ["Handcuffs"] = {"move_m@prisoner_cuffed"},
  ["Heels"] = {"move_f@heels@c"},
  ["Heels2"] = {"move_f@heels@d"},
  ["Hipster"] = {"move_m@hipster@a"},
  ["Hobo"] = {"move_m@hobo@a"},
  ["Hurry"] = {"move_f@hurry@a"},
  ["Janitor"] = {"move_p_m_zero_janitor"},
  ["Janitor2"] = {"move_p_m_zero_slow"},
  ["Jog"] = {"move_m@jog@"},
  ["Lemar"] = {"anim_group_move_lemar_alley"},
  ["Lester"] = {"move_heist_lester"},
  ["Lester2"] = {"move_lester_caneup"},
  ["Maneater"] = {"move_f@maneater"},
  ["Michael"] = {"move_ped_bucket"},
  ["Money"] = {"move_m@money"},
  ["Posh"] = {"move_m@posh@"},
  ["Posh2"] = {"move_f@posh@"},
  ["Quick"] = {"move_m@quick"},
  ["Runner"] = {"female_fast_runner"},
  ["Sad"] = {"move_m@sad@a"},
  ["Sassy"] = {"move_m@sassy"},
  ["Sassy2"] = {"move_f@sassy"},
  ["Scared"] = {"move_f@scared"},
  ["Sexy"] = {"move_f@sexy@a"},
  ["Shady"] = {"move_m@shadyped@a"},
  ["Slow"] = {"move_characters@jimmy@slow@"},
  ["Swagger"] = {"move_m@swagger"},
  ["Tough"] = {"move_m@tough_guy@"},
  ["Tough2"] = {"move_f@tough_guy@"},
  ["Trash"] = {"clipset@move@trash_fast_turn"},
  ["Trash2"] = {"missfbi4prepp1_garbageman"},
  ["Trevor"] = {"move_p_m_two"},
  ["Wide"] = {"move_m@bag"},
  -- I cant get these to work for some reason, if anyone knows a fix lmk
  --["Caution"] = {"move_m@caution"},
  --["Chubby"] = {"anim@move_m@chubby@a"},
  --["Crazy"] = {"move_m@crazy"},
  --["Joy"] = {"move_m@joy@a"},
  --["Power"] = {"move_m@power"},
  --["Sad2"] = {"anim@move_m@depression@a"},
  --["Sad3"] = {"move_m@depression@b"},
  --["Sad4"] = {"move_m@depression@d"},
  --["Wading"] = {"move_m@wading"},
}

DP.Shared = {
   --[emotename] = {dictionary, animation, displayname, targetemotename, additionalanimationoptions}
   -- you dont have to specify targetemoteanem, if you do dont it will just play the same animation on both.
   -- targetemote is used for animations that have a corresponding animation to the other player.
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", "handshake2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
       SyncOffsetFront = 0.9
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", "handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug", "hug2", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.05,
   }},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2", "hug", AnimationOptions =
   {
       EmoteMoving = false,
       EmoteDuration = 5000,
       SyncOffsetFront = 1.13
   }},
   ["bro"] = {"mp_ped_interaction", "hugs_guy_a", "Bro", "bro2", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["bro2"] = {"mp_ped_interaction", "hugs_guy_b", "Bro 2", "bro", AnimationOptions =
   {
        SyncOffsetFront = 1.14
   }},
   ["give"] = {"mp_common", "givetake1_a", "Give", "give2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["give2"] = {"mp_common", "givetake1_b", "Give 2", "give", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["baseball"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_a", "Baseball", "baseballthrow"},
   ["baseballthrow"] = {"anim@arena@celeb@flat@paired@no_props@", "baseball_a_player_b", "Baseball Throw", "baseball"},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", "stickupscared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickupscared"] = {"missminuteman_1ig_2", "handsup_base", "Stickup Scared", "stickup", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["punch"] = {"melee@unarmed@streamed_variations", "plyr_takedown_rear_lefthook", "Punch", "punched"},
   ["punched"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_cross_r", "Punched", "punch"},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt", "headbutted"},
   ["headbutted"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_headbutt", "Headbutted", "headbutt"},
   ["slap2"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_backslap", "Slap 2", "slapped2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", "slapped", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["slapped"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_slap", "Slapped", "slap"},
   ["slapped2"] = {"melee@unarmed@streamed_variations", "victim_takedown_front_backslap", "Slapped 2", "slap2"},
}

DP.Dances = {
   ["dancef"] = {"anim@amb@nightclub@dancers@solomun_entourage@", "mi_dance_facedj_17_v1_female^1", "Dance F", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center", "Dance F2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef4"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^1", "Dance F4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef5"] = {"anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity", "hi_dance_facedj_09_v2_female^3", "Dance F5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancef6"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "high_center_up", "Dance F6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center", "Dance Slow 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow3"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "low_center_down", "Dance Slow 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow4"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center", "Dance Slow 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance"] = {"anim@amb@nightclub@dancers@podium_dancers@", "hi_dance_facedj_17_v2_male^5", "Dance", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance2"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_down", "Dance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance3"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "high_center", "Dance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance4"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "high_center_up", "Dance 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceupper"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Upper", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceupper2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "high_center_up", "Dance Upper 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceshy"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_a@", "low_center", "Dance Shy", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceshy2"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_b@", "low_center_down", "Dance Shy 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["danceslow"] = {"anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", "low_center", "Dance Slow", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly9"] = {"rcmnigel1bnmt_1b", "dance_loop_tyler", "Dance Silly 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance6"] = {"misschinese2_crystalmazemcs1_cs", "dance_loop_tao", "Dance 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance7"] = {"misschinese2_crystalmazemcs1_ig", "dance_loop_tao", "Dance 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance8"] = {"missfbi3_sniping", "dance_m_default", "Dance 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly"] = {"special_ped@mountain_dancer@monologue_3@monologue_3a", "mnt_dnc_buttwag", "Dance Silly", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly2"] = {"move_clown@p_m_zero_idles@", "fidget_short_dance", "Dance Silly 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly3"] = {"move_clown@p_m_two_idles@", "fidget_short_dance", "Dance Silly 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly4"] = {"anim@amb@nightclub@lazlow@hi_podium@", "danceidle_hi_11_buttwiggle_b_laz", "Dance Silly 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly5"] = {"timetable@tracy@ig_5@idle_a", "idle_a", "Dance Silly 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly6"] = {"timetable@tracy@ig_8@idle_b", "idle_d", "Dance Silly 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dance9"] = {"anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", "med_center_up", "Dance 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["dancesilly8"] = {"anim@mp_player_intcelebrationfemale@the_woogie", "the_woogie", "Dance Silly 8", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dancesilly7"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_b@", "high_center", "Dance Silly 7", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["dance5"] = {"anim@amb@casino@mini@dance@dance_solo@female@var_a@", "med_center", "Dance 5", AnimationOptions =
   {
       EmoteLoop = true
   }},
   ["danceglowstick"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_13_mi_hi_sexualgriding_laz", "Dance Glowsticks", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["danceglowstick2"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_12_mi_hi_bootyshake_laz", "Dance Glowsticks 2", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["danceglowstick3"] = {"anim@amb@nightclub@lazlow@hi_railing@", "ambclub_09_mi_hi_bellydancer_laz", "Dance Glowsticks 3", AnimationOptions =
   {
       Prop = 'ba_prop_battle_glowstick_01',
       PropBone = 28422,
       PropPlacement = {0.0700,0.1400,0.0,-80.0,20.0},
       SecondProp = 'ba_prop_battle_glowstick_01',
       SecondPropBone = 60309,
       SecondPropPlacement = {0.0700,0.0900,0.0,-120.0,-20.0},
       EmoteLoop = true,
   }},
   ["dancehorse"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_15_handup_laz", "Dance Horse", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dancehorse2"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "crowddance_hi_11_handup_laz", "Dance Horse 2", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
   ["dancehorse3"] = {"anim@amb@nightclub@lazlow@hi_dancefloor@", "dancecrowd_li_11_hu_shimmy_laz", "Dance Horse 3", AnimationOptions =
   {
       Prop = "ba_prop_battle_hobby_horse",
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
   }},
}

DP.Emotes = {
   ["drink"] = {"mp_player_inteat@pnq", "loop", "Drink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2500,
   }},
   ["airforce01"] = { -- MissSnowie
        "airforce@at_ease",
        "base",
        "Airforce - At Ease", -- MissSnowie
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false,
       }
    },
	["airforce02"] = { -- MissSnowie
        "airforce@attention",
        "base",
        "Airforce - Attention",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false,
       }
    },
	["airforce03"] = { -- MissSnowie
        "airforce@parade_rest",
        "base",
        "Airforce - Parade Rest",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false,
       }
    },
	["airforce04"] = {
        "airforce@salute",
        "base",
        "Airforce - Salute",
        AnimationOptions = {
            EmoteLoop = true,
            EmoteMoving = false,
       }
    },
   ["beast"] = {"anim@mp_fm_event@intro", "beast_transform", "Beast", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000,
   }},
   ["chill"] = {"switch@trevor@scares_tramp", "trev_scares_tramp_idle_tramp", "Chill", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_girl", "Cloudgaze", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cloudgaze2"] = {"switch@trevor@annoys_sunbathers", "trev_annoys_sunbathers_loop_guy", "Cloudgaze 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["prone"] = {"missfbi3_sniping", "prone_dave", "Prone", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["pullover"] = {"misscarsteal3pullover", "pull_over_right", "Pullover", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["idle"] = {"anim@heists@heist_corona@team_idles@male_a", "idle", "Idle", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle8"] = {"amb@world_human_hang_out_street@male_b@idle_a", "idle_b", "Idle 8"},
   ["idle9"] = {"friends@fra@ig_1", "base_idle", "Idle 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle10"] = {"mp_move@prostitute@m@french", "idle", "Idle 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["idle11"] = {"random@countrysiderobbery", "idle_a", "Idle 11", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle2"] = {"anim@heists@heist_corona@team_idles@female_a", "idle", "Idle 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle3"] = {"anim@heists@humane_labs@finale@strip_club", "ped_b_celebrate_loop", "Idle 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle4"] = {"anim@mp_celebration@idles@female", "celebration_idle_f_a", "Idle 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle5"] = {"anim@mp_corona_idles@female_b@idle_a", "idle_a", "Idle 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle6"] = {"anim@mp_corona_idles@male_c@idle_a", "idle_a", "Idle 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idle7"] = {"anim@mp_corona_idles@male_d@idle_a", "idle_a", "Idle 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait3"] = {"amb@world_human_hang_out_street@female_hold_arm@idle_a", "idle_a", "Wait 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd1", "Idle Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk2"] = {"random@drunk_driver_1", "drunk_driver_stand_loop_dd2", "Idle Drunk 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["idledrunk3"] = {"missarmenian2", "standing_idle_loop_drunk", "Idle Drunk 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airguitar"] = {"anim@mp_player_intcelebrationfemale@air_guitar", "air_guitar", "Air Guitar"},
   ["airsynth"] = {"anim@mp_player_intcelebrationfemale@air_synth", "air_synth", "Air Synth"},
   ["argue"] = {"misscarsteal4@actor", "actor_berating_loop", "Argue", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["argue2"] = {"oddjobs@assassinate@vice@hooker", "argue_a", "Argue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bartender"] = {"anim@amb@clubhouse@bar@drink@idle_a", "idle_a_bartender", "Bartender", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["blowkiss"] = {"anim@mp_player_intcelebrationfemale@blow_kiss", "blow_kiss", "Blow Kiss"},
   ["blowkiss2"] = {"anim@mp_player_intselfieblow_kiss", "exit", "Blow Kiss 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000

   }},
   ["curtsy"] = {"anim@mp_player_intcelebrationpaired@f_f_sarcastic", "sarcastic_left", "Curtsy"},
   ["bringiton"] = {"misscommon@response", "bring_it_on", "Bring It On", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["comeatmebro"] = {"mini@triathlon", "want_some_of_this", "Come at me bro", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000
   }},
   ["cop2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Cop 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cop3"] = {"amb@code_human_police_investigate@idle_a", "idle_b", "Cop 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crossarms"] = {"amb@world_human_hang_out_street@female_arms_crossed@idle_a", "idle_a", "Crossarms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms2"] = {"amb@world_human_hang_out_street@male_c@idle_a", "idle_b", "Crossarms 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["crossarms3"] = {"anim@heists@heist_corona@single_team", "single_team_loop_boss", "Crossarms 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms4"] = {"random@street_race", "_car_b_lookout", "Crossarms 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms5"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Crossarms 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms2"] = {"anim@amb@nightclub@peds@", "rcmme_amanda1_stand_loop_cop", "Fold Arms 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarms6"] = {"random@shop_gunstore", "_idle", "Crossarms 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["foldarms"] = {"anim@amb@business@bgen@bgen_no_work@", "stand_phone_phoneputdown_idle_nowork", "Fold Arms", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["crossarmsside"] = {"rcmnigel1a_band_groupies", "base_m2", "Crossarms Side", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["damn"] = {"gestures@m@standing@casual", "gesture_damn", "Damn", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["damn2"] = {"anim@am_hold_up@male", "shoplift_mid", "Damn 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["pointdown"] = {"gestures@f@standing@casual", "gesture_hand_down", "Point Down", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["surrender"] = {"random@arrests@busted", "idle_a", "Surrender", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["facepalm2"] = {"anim@mp_player_intcelebrationfemale@face_palm", "face_palm", "Facepalm 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm"] = {"random@car_thief@agitated@idle_a", "agitated_idle_a", "Facepalm", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm3"] = {"missminuteman_1ig_2", "tasered_2", "Facepalm 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 8000
   }},
   ["facepalm4"] = {"anim@mp_player_intupperface_palm", "idle_a", "Facepalm 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fallover"] = {"random@drunk_driver_1", "drunk_fall_over", "Fall Over"},
   ["fallover2"] = {"mp_suicide", "pistol", "Fall Over 2"},
   ["fallover3"] = {"mp_suicide", "pill", "Fall Over 3"},
   ["fallover4"] = {"friends@frf@ig_2", "knockout_plyr", "Fall Over 4"},
   ["fallover5"] = {"anim@gangops@hostage@", "victim_fail", "Fall Over 5"},
   ["fallasleep"] = {"mp_sleep", "sleep_loop", "Fall Asleep", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["fightme"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_c", "Fight Me"},
   ["fightme2"] = {"anim@deathmatch_intros@unarmed", "intro_male_unarmed_e", "Fight Me 2"},
   ["finger"] = {"anim@mp_player_intselfiethe_bird", "idle_a", "Finger", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["finger2"] = {"anim@mp_player_intupperfinger", "idle_a_fp", "Finger 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["handshake"] = {"mp_ped_interaction", "handshake_guy_a", "Handshake", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["handshake2"] = {"mp_ped_interaction", "handshake_guy_b", "Handshake 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000
   }},
   ["wait4"] = {"amb@world_human_hang_out_street@Female_arm_side@idle_a", "idle_a", "Wait 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["wait5"] = {"missclothing", "idle_storeclerk", "Wait 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait6"] = {"timetable@amanda@ig_2", "ig_2_base_amanda", "Wait 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait7"] = {"rcmnigel1cnmt_1c", "base", "Wait 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait8"] = {"rcmjosh1", "idle", "Wait 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait9"] = {"rcmjosh2", "josh_2_intp1_base", "Wait 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait10"] = {"timetable@amanda@ig_3", "ig_3_base_tracy", "Wait 10", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait11"] = {"misshair_shop@hair_dressers", "keeper_base", "Wait 11", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hiking"] = {"move_m@hiking", "idle", "Hiking", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["hug"] = {"mp_ped_interaction", "kisses_guy_a", "Hug"},
   ["hug2"] = {"mp_ped_interaction", "kisses_guy_b", "Hug 2"},
   ["hug3"] = {"mp_ped_interaction", "hugs_guy_a", "Hug 3"},
   ["inspect"] = {"random@train_tracks", "idle_e", "Inspect"},
   ["jazzhands"] = {"anim@mp_player_intcelebrationfemale@jazz_hands", "jazz_hands", "Jazzhands", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 6000,
   }},
   ["jog2"] = {"amb@world_human_jog_standing@male@idle_a", "idle_a", "Jog 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog3"] = {"amb@world_human_jog_standing@female@idle_a", "idle_a", "Jog 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog4"] = {"amb@world_human_power_walker@female@idle_a", "idle_a", "Jog 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jog5"] = {"move_m@joy@a", "walk", "Jog 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["jumpingjacks"] = {"timetable@reunited@ig_2", "jimmy_getknocked", "Jumping Jacks", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel2"] = {"rcmextreme3", "idle", "Kneel 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["kneel3"] = {"amb@world_human_bum_wash@male@low@idle_a", "idle_a", "Kneel 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knock"] = {"timetable@jimmy@doorknock@", "knockdoor_idle", "Knock", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true,
   }},
   ["knock2"] = {"missheistfbi3b_ig7", "lift_fibagent_loop", "Knock 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["knucklecrunch"] = {"anim@mp_player_intcelebrationfemale@knuckle_crunch", "knuckle_crunch", "Knuckle Crunch", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance"] = {"mp_safehouse", "lap_dance_girl", "Lapdance"},
   ["lean2"] = {"amb@world_human_leaning@female@wall@back@hand_up@idle_a", "idle_a", "Lean 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean3"] = {"amb@world_human_leaning@female@wall@back@holding_elbow@idle_a", "idle_a", "Lean 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean4"] = {"amb@world_human_leaning@male@wall@back@foot_up@idle_a", "idle_a", "Lean 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lean5"] = {"amb@world_human_leaning@male@wall@back@hands_together@idle_b", "idle_b", "Lean 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanflirt"] = {"random@street_race", "_car_a_flirt_girl", "Lean Flirt", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar2"] = {"amb@prop_human_bum_shopping_cart@male@idle_a", "idle_c", "Lean Bar 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar3"] = {"anim@amb@nightclub@lazlow@ig1_vip@", "clubvip_base_laz", "Lean Bar 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanbar4"] = {"anim@heists@prison_heist", "ped_b_loop_a", "Lean Bar 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["leanhigh"] = {"anim@mp_ferris_wheel", "idle_a_player_one", "Lean High", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanhigh2"] = {"anim@mp_ferris_wheel", "idle_a_player_two", "Lean High 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside"] = {"timetable@mime@01_gc", "idle_a", "Leanside", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside2"] = {"misscarstealfinale", "packer_idle_1_trevor", "Leanside 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside3"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["leanside4"] = {"misscarstealfinalecar_5_ig_1", "waitloop_lamar", "Leanside 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["leanside5"] = {"rcmjosh2", "josh_2_intp1_base", "Leanside 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = false,
   }},
   ["me"] = {"gestures@f@standing@casual", "gesture_me_hard", "Me", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000
   }},
   ["mechanic"] = {"mini@repair", "fixing_a_ped", "Mechanic", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mechanic2"] = {"amb@world_human_vehicle_mechanic@male@base", "idle_a", "Mechanic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic3"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mechanic4"] = {"anim@amb@clubhouse@tutorial@bkr_tut_ig3@", "machinic_loop_mechandplayer", "Mechanic 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["medic2"] = {"amb@medic@standing@tendtodead@base", "base", "Medic 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["meditate"] = {"rcmcollect_paperleadinout@", "meditiate_idle", "Meditiate", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate2"] = {"rcmepsilonism3", "ep_3_rcm_marnie_meditating", "Meditiate 2", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["meditate3"] = {"rcmepsilonism3", "base_loop", "Meditiate 3", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
   }},
   ["metal"] = {"anim@mp_player_intincarrockstd@ps@", "idle_a", "Metal", AnimationOptions = -- CHANGE ME
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no"] = {"anim@heists@ornate_bank@chat_manager", "fail", "No", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["no2"] = {"mp_player_int_upper_nod", "mp_player_int_nod_no", "No 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nosepick"] = {"anim@mp_player_intcelebrationfemale@nose_pick", "nose_pick", "Nose Pick", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["noway"] = {"gestures@m@standing@casual", "gesture_no_way", "No Way", AnimationOptions =
   {
       EmoteDuration = 1500,
       EmoteMoving = true,
   }},
   ["ok"] = {"anim@mp_player_intselfiedock", "idle_a", "OK", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["outofbreath"] = {"re@construction", "out_of_breath", "Out of Breath", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pickup"] = {"random@domestic", "pickup_low", "Pickup"},
   ["push"] = {"missfinale_c2ig_11", "pushcar_offcliff_f", "Push", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["push2"] = {"missfinale_c2ig_11", "pushcar_offcliff_m", "Push 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["point"] = {"gestures@f@standing@casual", "gesture_point", "Point", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pushup"] = {"amb@world_human_push_ups@male@idle_a", "idle_d", "Pushup", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["countdown"] = {"random@street_race", "grid_girl_race_start", "Countdown", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pointright"] = {"mp_gun_shop_tut", "indicate_right", "Point Right", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute"] = {"anim@mp_player_intincarsalutestd@ds@", "idle_a", "Salute", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute2"] = {"anim@mp_player_intincarsalutestd@ps@", "idle_a", "Salute 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["salute3"] = {"anim@mp_player_intuppersalute", "idle_a", "Salute 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared"] = {"random@domestic", "f_distressed_loop", "Scared", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["scared2"] = {"random@homelandsecurity", "knees_loop_girl", "Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["screwyou"] = {"misscommon@response", "screw_you", "Screw You", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["shakeoff"] = {"move_m@_idles@shake_off", "shakeoff_1", "Shake Off", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3500,
   }},
   ["shot"] = {"random@dealgonewrong", "idle_a", "Shot", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sleep"] = {"timetable@tracy@sleep@", "idle_c", "Sleep", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["shrug"] = {"gestures@f@standing@casual", "gesture_shrug_hard", "Shrug", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["shrug2"] = {"gestures@m@standing@casual", "gesture_shrug_hard", "Shrug 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["sit"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_idle_nowork", "Sit", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit2"] = {"rcm_barry3", "barry_3_sit_loop", "Sit 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit3"] = {"amb@world_human_picnic@male@idle_a", "idle_a", "Sit 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit4"] = {"amb@world_human_picnic@female@idle_a", "idle_a", "Sit 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit5"] = {"anim@heists@fleeca_bank@ig_7_jetski_owner", "owner_idle", "Sit 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit6"] = {"timetable@jimmy@mics3_ig_15@", "idle_a_jimmy", "Sit 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit7"] = {"anim@amb@nightclub@lazlow@lo_alone@", "lowalone_base_laz", "Sit 7", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit8"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_jimmy", "Sit 8", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sit9"] = {"amb@world_human_stupor@male@idle_a", "idle_a", "Sit 9", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitlean"] = {"timetable@tracy@ig_14@", "ig_14_base_tracy", "Sit Lean", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitsad"] = {"anim@amb@business@bgen@bgen_no_work@", "sit_phone_phoneputdown_sleeping-noworkfemale", "Sit Sad", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared"] = {"anim@heists@ornate_bank@hostages@hit", "hit_loop_ped_b", "Sit Scared", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared2"] = {"anim@heists@ornate_bank@hostages@ped_c@", "flinch_loop", "Sit Scared 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitscared3"] = {"anim@heists@ornate_bank@hostages@ped_e@", "flinch_loop", "Sit Scared 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitdrunk"] = {"timetable@amanda@drunk@base", "base", "Sit Drunk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair2"] = {"timetable@ron@ig_5_p3", "ig_5_p3_base", "Sit Chair 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair3"] = {"timetable@reunited@ig_10", "base_amanda", "Sit Chair 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair4"] = {"timetable@ron@ig_3_couch", "base", "Sit Chair 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair5"] = {"timetable@jimmy@mics3_ig_15@", "mics3_15_base_tracy", "Sit Chair 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchair6"] = {"timetable@maid@couch@", "base", "Sit Chair 6", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sitchairside"] = {"timetable@ron@ron_ig_2_alt1", "ig_2_alt1_base", "Sit Chair Side", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["situp"] = {"amb@world_human_sit_ups@male@idle_a", "idle_a", "Sit Up", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clapangry"] = {"anim@arena@celeb@flat@solo@no_props@", "angry_clap_a_player_a", "Clap Angry", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slowclap3"] = {"anim@mp_player_intupperslow_clap", "idle_a", "Slow Clap 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clap"] = {"amb@world_human_cheering@male_a", "base", "Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap"] = {"anim@mp_player_intcelebrationfemale@slow_clap", "slow_clap", "Slow Clap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["slowclap2"] = {"anim@mp_player_intcelebrationmale@slow_clap", "slow_clap", "Slow Clap 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smell"] = {"move_p_m_two_idles@generic", "fidget_sniff_fingers", "Smell", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stickup"] = {"random@countryside_gang_fight", "biker_02_stickup_loop", "Stick Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stumble"] = {"misscarsteal4@actor", "stumble", "Stumble", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stunned"] = {"stungun@standing", "damage", "Stunned", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe"] = {"amb@world_human_sunbathe@male@back@base", "base", "Sunbathe", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["sunbathe2"] = {"amb@world_human_sunbathe@female@back@base", "base", "Sunbathe 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["t"] = {"missfam5_yoga", "a2_pose", "T", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["t2"] = {"mp_sleep", "bind_pose_180", "T 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["think5"] = {"mp_cp_welcome_tutthink", "b_think", "Think 5", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["think"] = {"misscarsteal4@aliens", "rehearsal_base_idle_director", "Think", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["think3"] = {"timetable@tracy@ig_8@base", "base", "Think 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},

   ["think2"] = {"missheist_jewelleadinout", "jh_int_outro_loop_a", "Think 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup3"] = {"anim@mp_player_intincarthumbs_uplow@ds@", "enter", "Thumbs Up 3", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["thumbsup2"] = {"anim@mp_player_intselfiethumbs_up", "idle_a", "Thumbs Up 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["thumbsup"] = {"anim@mp_player_intupperthumbs_up", "idle_a", "Thumbs Up", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type"] = {"anim@heists@prison_heiststation@cop_reactions", "cop_b_idle", "Type", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type2"] = {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop", "Type 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type3"] = {"mp_prison_break", "hack_loop", "Type 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["type4"] = {"mp_fbi_heist", "loop", "Type 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["warmth"] = {"amb@world_human_stand_fire@male@idle_a", "idle_a", "Warmth", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave4"] = {"random@mugging5", "001445_01_gangintimidation_1_female_idle_b", "Wave 4", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["wave2"] = {"anim@mp_player_intcelebrationfemale@wave", "wave", "Wave 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave3"] = {"friends@fra@ig_1", "over_here_idle_a", "Wave 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave"] = {"friends@frj@ig_1", "wave_a", "Wave", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave5"] = {"friends@frj@ig_1", "wave_b", "Wave 5", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave6"] = {"friends@frj@ig_1", "wave_c", "Wave 6", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave7"] = {"friends@frj@ig_1", "wave_d", "Wave 7", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave8"] = {"friends@frj@ig_1", "wave_e", "Wave 8", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wave9"] = {"gestures@m@standing@casual", "gesture_hello", "Wave 9", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whistle"] = {"taxi_hail", "hail_taxi", "Whistle", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 1300,
   }},
   ["whistle2"] = {"rcmnigel1c", "hailing_whistle_waive_a", "Whistle 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["yeah"] = {"anim@mp_player_intupperair_shagging", "idle_a", "Yeah", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lift"] = {"random@hitch_lift", "idle_f", "Lift", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lol"] = {"anim@arena@celeb@flat@paired@no_props@", "laugh_a_player_b", "LOL", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lol2"] = {"anim@arena@celeb@flat@solo@no_props@", "giggle_a_player_b", "LOL 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["statue2"] = {"fra_0_int-1", "cs_lamardavis_dual-1", "Statue 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["statue3"] = {"club_intro2-0", "csb_englishdave_dual-0", "Statue 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["gangsign"] = {"mp_player_int_uppergang_sign_a", "mp_player_int_gang_sign_a", "Gang Sign", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["gangsign2"] = {"mp_player_int_uppergang_sign_b", "mp_player_int_gang_sign_b", "Gang Sign 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["passout"] = {"missarmenian2", "drunk_loop", "Passout", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout2"] = {"missarmenian2", "corpse_search_exit_ped", "Passout 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout3"] = {"anim@gangops@morgue@table@", "body_search", "Passout 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout4"] = {"mini@cpr@char_b@cpr_def", "cpr_pumpchest_idle", "Passout 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["passout5"] = {"random@mugging4", "flee_backward_loop_shopkeeper", "Passout 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["petting"] = {"creatures@rottweiler@tricks@", "petting_franklin", "Petting", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["crawl"] = {"move_injured_ground", "front_loop", "Crawl", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["flip2"] = {"anim@arena@celeb@flat@solo@no_props@", "cap_a_player_a", "Flip 2"},
   ["flip"] = {"anim@arena@celeb@flat@solo@no_props@", "flip_a_player_a", "Flip"},
   ["slide"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_a_player_a", "Slide"},
   ["slide2"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_b_player_a", "Slide 2"},
   ["slide3"] = {"anim@arena@celeb@flat@solo@no_props@", "slide_c_player_a", "Slide 3"},
   ["slugger"] = {"anim@arena@celeb@flat@solo@no_props@", "slugger_a_player_a", "Slugger"},
   ["flipoff"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_a_1st", "Flip Off", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["flipoff2"] = {"anim@arena@celeb@podium@no_prop@", "flip_off_c_1st", "Flip Off 2", AnimationOptions =
   {
       EmoteMoving = true,
   }},
   ["bow"] = {"anim@arena@celeb@podium@no_prop@", "regal_c_1st", "Bow", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bow2"] = {"anim@arena@celeb@podium@no_prop@", "regal_a_1st", "Bow 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["keyfob"] = {"anim@mp_player_intmenu@key_fob@", "fob_click", "Key Fob", AnimationOptions =
   {
       EmoteLoop = false,
       EmoteMoving = true,
       EmoteDuration = 1000,
   }},
   ["golfswing"] = {"rcmnigel1d", "swing_a_mark", "Golf Swing"},
   ["eat"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Eat", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 3000,
   }},
   ["reaching"] = {"move_m@intimidation@cop@unarmed", "idle", "Reaching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait"] = {"random@shop_tattoo", "_idle_a", "Wait", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait2"] = {"missbigscore2aig_3", "wait_for_van_c", "Wait 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait12"] = {"rcmjosh1", "idle", "Wait 12", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["wait13"] = {"rcmnigel1a", "base", "Wait 13", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["lapdance2"] = {"mini@strip_club@private_dance@idle", "priv_dance_idle", "Lapdance 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part2", "priv_dance_p2", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["lapdance3"] = {"mini@strip_club@private_dance@part3", "priv_dance_p3", "Lapdance 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["twerk"] = {"switch@trevor@mocks_lapdance", "001443_01_trvs_28_idle_stripper", "Twerk", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["slap"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_slap", "Slap", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
       EmoteDuration = 2000,
   }},
   ["headbutt"] = {"melee@unarmed@streamed_variations", "plyr_takedown_front_headbutt", "Headbutt"},
   ["fishdance"] = {"anim@mp_player_intupperfind_the_fish", "idle_a", "Fish Dance", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace"] = {"mp_player_int_upperpeace_sign", "mp_player_int_peace_sign", "Peace", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peace2"] = {"anim@mp_player_intupperpeace", "idle_a", "Peace 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cpr"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cpr2"] = {"mini@cpr@char_a@cpr_str", "cpr_pumpchest", "CPR 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["ledge"] = {"missfbi1", "ledge_loop", "Ledge", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["airplane"] = {"missfbi1", "ledge_loop", "Air Plane", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["peek"] = {"random@paparazzi@peek", "left_peek_a", "Peek", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["cough"] = {"timetable@gardener@smoking_joint", "idle_cough", "Cough", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["stretch"] = {"mini@triathlon", "idle_e", "Stretch", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch2"] = {"mini@triathlon", "idle_f", "Stretch 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch3"] = {"mini@triathlon", "idle_d", "Stretch 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["stretch4"] = {"rcmfanatic1maryann_stretchidle_b", "idle_e", "Stretch 4", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["celebrate"] = {"rcmfanatic1celebrate", "celebrate", "Celebrate", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["punching"] = {"rcmextreme2", "loop_punching", "Punching", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["superhero"] = {"rcmbarry", "base", "Superhero", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["superhero2"] = {"rcmbarry", "base", "Superhero 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mindcontrol"] = {"rcmbarry", "mind_control_b_loop", "Mind Control", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["mindcontrol2"] = {"rcmbarry", "bar_1_attack_idle_aln", "Mind Control 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown"] = {"rcm_barry2", "clown_idle_0", "Clown", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown2"] = {"rcm_barry2", "clown_idle_1", "Clown 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown3"] = {"rcm_barry2", "clown_idle_2", "Clown 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["clown4"] = {"rcm_barry2", "clown_idle_3", "Clown 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["clown5"] = {"rcm_barry2", "clown_idle_6", "Clown 5", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes"] = {"mp_clothing@female@trousers", "try_trousers_neutral_a", "Try Clothes", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes2"] = {"mp_clothing@female@shirt", "try_shirt_positive_a", "Try Clothes 2", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["tryclothes3"] = {"mp_clothing@female@shoes", "try_shoes_positive_a", "Try Clothes 3", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["nervous2"] = {"mp_missheist_countrybank@nervous", "nervous_idle", "Nervous 2", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous"] = {"amb@world_human_bum_standing@twitchy@idle_a", "idle_c", "Nervous", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["nervous3"] = {"rcmme_tracey1", "nervous_loop", "Nervous 3", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["uncuff"] = {"mp_arresting", "a_uncuff", "Uncuff", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["namaste"] = {"timetable@amanda@ig_4", "ig_4_base", "Namaste", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["dj"] = {"anim@amb@nightclub@djs@dixon@", "dixn_dance_cntr_open_dix", "DJ", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["threaten"] = {"random@atmrobberygen", "b_atm_mugging", "Threaten", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["radio"] = {"random@arrests", "generic_radio_chatter", "Radio", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["pull"] = {"random@mugging4", "struggle_loop_b_thief", "Pull", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bird"] = {"random@peyote@bird", "wakeup", "Bird"},
   ["chicken"] = {"random@peyote@chicken", "wakeup", "Chicken", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bark"] = {"random@peyote@dog", "wakeup", "Bark"},
   ["rabbit"] = {"random@peyote@rabbit", "wakeup", "Rabbit"},
   ["spiderman"] = {"missexile3", "ex03_train_roof_idle", "Spider-Man", AnimationOptions =
   {
       EmoteLoop = true,
   }},
   ["boi"] = {"special_ped@jane@monologue_5@monologue_5c", "brotheradrianhasshown_2", "BOI", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 3000,
   }},
   ["adjust"] = {"missmic4", "michael_tux_fidget", "Adjust", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteDuration = 4000,
   }},
   ["handsup"] = {"missminuteman_1ig_2", "handsup_base", "Hands Up", AnimationOptions =
   {
      EmoteMoving = true,
      EmoteLoop = true,
   }},
   ["pee"] = {"misscarsteal2peeing", "peeing_loop", "Pee", AnimationOptions =
   {
       EmoteStuck = true,
       PtfxAsset = "scr_amb_chop",
       PtfxName = "ent_anim_dog_peeing",
       PtfxNoProp = true,
       PtfxPlacement = {-0.05, 0.3, 0.0, 0.0, 90.0, 90.0, 1.0},
       --PtfxInfo = Config.Languages[Config.MenuLanguage]['pee'],
       PtfxWait = 3000,
   }},

-----------------------------------------------------------------------------------------------------------
------ These are Scenarios, some of these dont work on women and some other issues, but still good to have.
-----------------------------------------------------------------------------------------------------------

   ["atm"] = {"Scenario", "PROP_HUMAN_ATM", "ATM"},
   ["bbq"] = {"MaleScenario", "PROP_HUMAN_BBQ", "BBQ"},
   ["bumbin"] = {"Scenario", "PROP_HUMAN_BUM_BIN", "Bum Bin"},
   ["bumsleep"] = {"Scenario", "WORLD_HUMAN_BUM_SLUMPED", "Bum Sleep"},
   ["cheer"] = {"Scenario", "WORLD_HUMAN_CHEERING", "Cheer"},
   ["chinup"] = {"Scenario", "PROP_HUMAN_MUSCLE_CHIN_UPS", "Chinup"},
   ["clipboard2"] = {"MaleScenario", "WORLD_HUMAN_CLIPBOARD", "Clipboard 2"},
   ["cop"] = {"Scenario", "WORLD_HUMAN_COP_IDLES", "Cop"},
   ["copbeacon"] = {"MaleScenario", "WORLD_HUMAN_CAR_PARK_ATTENDANT", "Cop Beacon"},
   ["filmshocking"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Film Shocking"},
   ["flex"] = {"Scenario", "WORLD_HUMAN_MUSCLE_FLEX", "Flex"},
   ["guard"] = {"Scenario", "WORLD_HUMAN_GUARD_STAND", "Guard"},
   ["hammer"] = {"Scenario", "WORLD_HUMAN_HAMMERING", "Hammer"},
   ["hangout"] = {"Scenario", "WORLD_HUMAN_HANG_OUT_STREET", "Hangout"},
   ["impatient"] = {"Scenario", "WORLD_HUMAN_STAND_IMPATIENT", "Impatient"},
   ["janitor"] = {"Scenario", "WORLD_HUMAN_JANITOR", "Janitor"},
   ["jog"] = {"Scenario", "WORLD_HUMAN_JOG_STANDING", "Jog"},
   ["kneel"] = {"Scenario", "CODE_HUMAN_MEDIC_KNEEL", "Kneel"},
   ["leafblower"] = {"MaleScenario", "WORLD_HUMAN_GARDENER_LEAF_BLOWER", "Leafblower"},
   ["lean"] = {"Scenario", "WORLD_HUMAN_LEANING", "Lean"},
   ["leanbar"] = {"Scenario", "PROP_HUMAN_BUM_SHOPPING_CART", "Lean Bar"},
   ["lookout"] = {"Scenario", "CODE_HUMAN_CROSS_ROAD_WAIT", "Lookout"},
   ["maid"] = {"Scenario", "WORLD_HUMAN_MAID_CLEAN", "Maid"},
   ["medic"] = {"Scenario", "CODE_HUMAN_MEDIC_TEND_TO_DEAD", "Medic"},
   ["musician"] = {"MaleScenario", "WORLD_HUMAN_MUSICIAN", "Musician"},
   ["notepad2"] = {"Scenario", "CODE_HUMAN_MEDIC_TIME_OF_DEATH", "Notepad 2"},
   ["parkingmeter"] = {"Scenario", "PROP_HUMAN_PARKING_METER", "Parking Meter"},
   ["party"] = {"Scenario", "WORLD_HUMAN_PARTYING", "Party"},
   ["phone"] = {"Scenario", "WORLD_HUMAN_STAND_MOBILE", "Phone"},
   ["prosthigh"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", "Prostitue High"},
   ["prostlow"] = {"Scenario", "WORLD_HUMAN_PROSTITUTE_LOW_CLASS", "Prostitue Low"},
   ["puddle"] = {"Scenario", "WORLD_HUMAN_BUM_WASH", "Puddle"},
   ["record"] = {"Scenario", "WORLD_HUMAN_MOBILE_FILM_SHOCKING", "Record"},
   -- Sitchair is a litte special, since you want the player to be seated correctly.
   -- So we set it as "ScenarioObject" and do TaskStartScenarioAtPosition() instead of "AtPlace"
   ["sitchair"] = {"ScenarioObject", "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", "Sit Chair"},
   ["smoke"] = {"Scenario", "WORLD_HUMAN_SMOKING", "Smoke"},
   ["smokeweed"] = {"MaleScenario", "WORLD_HUMAN_DRUG_DEALER", "Smoke Weed"},
   ["statue"] = {"Scenario", "WORLD_HUMAN_HUMAN_STATUE", "Statue"},
   ["sunbathe3"] = {"Scenario", "WORLD_HUMAN_SUNBATHE", "Sunbathe 3"},
   ["sunbatheback"] = {"Scenario", "WORLD_HUMAN_SUNBATHE_BACK", "Sunbathe Back"},
   ["weld"] = {"Scenario", "WORLD_HUMAN_WELDING", "Weld"},
   ["windowshop"] = {"Scenario", "WORLD_HUMAN_WINDOW_SHOP_BROWSE", "Window Shop"},
   ["yoga"] = {"Scenario", "WORLD_HUMAN_YOGA", "Yoga"},
   -- CASINO DLC EMOTES (STREAMED)
   ["karate"] = {"anim@mp_player_intcelebrationfemale@karate_chops", "karate_chops", "Karate"},
   ["karate2"] = {"anim@mp_player_intcelebrationmale@karate_chops", "karate_chops", "Karate 2"},
   ["cutthroat"] = {"anim@mp_player_intcelebrationmale@cut_throat", "cut_throat", "Cut Throat"},
   ["cutthroat2"] = {"anim@mp_player_intcelebrationfemale@cut_throat", "cut_throat", "Cut Throat 2"},
   ["mindblown"] = {"anim@mp_player_intcelebrationmale@mind_blown", "mind_blown", "Mind Blown", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["mindblown2"] = {"anim@mp_player_intcelebrationfemale@mind_blown", "mind_blown", "Mind Blown 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing"] = {"anim@mp_player_intcelebrationmale@shadow_boxing", "shadow_boxing", "Boxing", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["boxing2"] = {"anim@mp_player_intcelebrationfemale@shadow_boxing", "shadow_boxing", "Boxing 2", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 4000
   }},
   ["stink"] = {"anim@mp_player_intcelebrationfemale@stinker", "stinker", "Stink", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["think4"] = {"anim@amb@casino@hangout@ped_male@stand@02b@idles", "idle_a", "Think 4", AnimationOptions =
   {
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["adjusttie"] = {"clothingtie", "try_tie_positive_a", "Adjust Tie", AnimationOptions =
   {
       EmoteMoving = true,
       EmoteDuration = 5000
   }},
}

DP.PropEmotes = {
   ["umbrella"] = {"amb@world_human_drinking@coffee@male@base", "base", "Umbrella", AnimationOptions =
   {
       Prop = "p_amb_brolly_01",
       PropBone = 57005,
       PropPlacement = {0.15, 0.005, 0.0, 87.0, -20.0, 180.0},
       --
       EmoteLoop = true,
       EmoteMoving = true,
   }},

-----------------------------------------------------------------------------------------------------
------ This is an example of an emote with 2 props, pretty simple! ----------------------------------
-----------------------------------------------------------------------------------------------------

   ["notepad"] = {"missheistdockssetup1clipboard@base", "base", "Notepad", AnimationOptions =
   {
       Prop = 'prop_notepad_01',
       PropBone = 18905,
       PropPlacement = {0.1, 0.02, 0.05, 10.0, 0.0, 0.0},
       SecondProp = 'prop_pencil_01',
       SecondPropBone = 58866,
       SecondPropPlacement = {0.11, -0.02, 0.001, -120.0, 0.0, 0.0},
       -- EmoteLoop is used for emotes that should loop, its as simple as that.
       -- Then EmoteMoving is used for emotes that should only play on the upperbody.
       -- The code then checks both values and sets the MovementType to the correct one
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["box"] = {"anim@heists@box_carry@", "idle", "Box", AnimationOptions =
   {
       Prop = "hei_prop_heist_box",
       PropBone = 60309,
       PropPlacement = {0.025, 0.08, 0.255, -145.0, 290.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["rose"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Rose", AnimationOptions =
   {
       Prop = "prop_single_rose",
       PropBone = 18905,
       PropPlacement = {0.13, 0.15, 0.0, -100.0, 0.0, -20.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke2"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_c", "Smoke 2", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke3"] = {"amb@world_human_aa_smoke@male@idle_a", "idle_b", "Smoke 3", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["smoke4"] = {"amb@world_human_smoking@female@idle_a", "idle_b", "Smoke 4", AnimationOptions =
   {
       Prop = 'prop_cs_ciggy_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["bong"] = {"anim@safehouse@bong", "bong_stage3", "Bong", AnimationOptions =
   {
       Prop = 'hei_heist_sh_bong_01',
       PropBone = 18905,
       PropPlacement = {0.10,-0.25,0.0,95.0,190.0,180.0},
   }},
   ["suitcase"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase", AnimationOptions =
   {
       Prop = "prop_ld_suitcase_01",
       PropBone = 57005,
       PropPlacement = {0.39, 0.0, 0.0, 0.0, 266.0, 60.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["suitcase2"] = {"missheistdocksprep1hold_cellphone", "static", "Suitcase 2", AnimationOptions =
   {
       Prop = "prop_security_case_01",
       PropBone = 57005,
       PropPlacement = {0.10, 0.0, 0.0, 0.0, 280.0, 53.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["mugshot"] = {"mp_character_creation@customise@male_a", "loop", "Mugshot", AnimationOptions =
   {
       Prop = 'prop_police_id_board',
       PropBone = 58868,
       PropPlacement = {0.12, 0.24, 0.0, 5.0, 0.0, 70.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["coffee"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Coffee", AnimationOptions =
   {
       Prop = 'p_amb_coffeecup_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["whiskey"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Whiskey", AnimationOptions =
   {
       Prop = 'prop_drink_whisky',
       PropBone = 28422,
       PropPlacement = {0.01, -0.01, -0.06, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["beer"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Beer", AnimationOptions =
   {
       Prop = 'prop_amb_beer_bottle',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["cup"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Cup", AnimationOptions =
   {
       Prop = 'prop_plastic_cup_02',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["donut"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Donut", AnimationOptions =
   {
       Prop = 'prop_amb_donut',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
       EmoteDuration = 4500
   }},
   ["burger"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Burger", AnimationOptions =
   {
       Prop = 'prop_cs_burger_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
       EmoteDuration = 4500
   }},
   ["sandwich"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Sandwich", AnimationOptions =
   {
       Prop = 'prop_sandwich_01',
       PropBone = 18905,
       PropPlacement = {0.13, 0.05, 0.02, -50.0, 16.0, 60.0},
       EmoteMoving = true,
       EmoteDuration = 4500
   }},
   ["soda"] = {"amb@world_human_drinking@coffee@male@idle_a", "idle_c", "Soda", AnimationOptions =
   {
       Prop = 'prop_ecola_can',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 130.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["egobar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Ego Bar", AnimationOptions =
   {
       Prop = 'prop_choc_ego',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteDuration = 3500
   }},
   ["wine"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Wine", AnimationOptions =
   {
       Prop = 'prop_drink_redwine',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["flute"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Flute", AnimationOptions =
   {
       Prop = 'prop_champ_flute',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["champagne"] = {"anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", "Champagne", AnimationOptions =
   {
       Prop = 'prop_drink_champ',
       PropBone = 18905,
       PropPlacement = {0.10, -0.03, 0.03, -100.0, 0.0, -10.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["cigar"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Cigar", AnimationOptions =
   {
       Prop = 'prop_cigar_02',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 600
   }},
   ["cigar2"] = {"mp_player_inteat@burger", "mp_player_int_eat_burger", "Cigar 2", AnimationOptions =
   {
       Prop = 'prop_cigar_01',
       PropBone = 47419,
       PropPlacement = {0.010, 0.0, 0.0, 50.0, 0.0, -80.0},
       EmoteMoving = true,
       EmoteDuration = 600
   }},
   ["guitar"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitar2"] = {"switch@trevor@guitar_beatdown", "001370_02_trvs_8_guitar_beatdown_idle_busker", "Guitar 2", AnimationOptions =
   {
       Prop = 'prop_acc_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.05, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric", AnimationOptions =
   {
       Prop = 'prop_el_guitar_01',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["guitarelectric2"] = {"amb@world_human_musician@guitar@male@idle_a", "idle_b", "Guitar Electric 2", AnimationOptions =
   {
       Prop = 'prop_el_guitar_03',
       PropBone = 24818,
       PropPlacement = {-0.1, 0.31, 0.1, 0.0, 20.0, 150.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["book"] = {"cellphone@", "cellphone_text_read_base", "Book", AnimationOptions =
   {
       Prop = 'prop_novel_01',
       PropBone = 6286,
       PropPlacement = {0.15, 0.03, -0.065, 0.0, 180.0, 90.0}, -- This positioning isnt too great, was to much of a hassle
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["bouquet"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Bouquet", AnimationOptions =
   {
       Prop = 'prop_snow_flower_02',
       PropBone = 24817,
       PropPlacement = {-0.29, 0.40, -0.02, -90.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["teddy"] = {"impexp_int-0", "mp_m_waremech_01_dual-0", "Teddy", AnimationOptions =
   {
       Prop = 'v_ilev_mr_rasberryclean',
       PropBone = 24817,
       PropPlacement = {-0.20, 0.46, -0.016, -180.0, -90.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["backpack"] = {"move_p_m_zero_rucksack", "idle", "Backpack", AnimationOptions =
   {
       Prop = 'p_michael_backpack_s',
       PropBone = 24818,
       PropPlacement = {0.07, -0.11, -0.05, 0.0, 90.0, 175.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["clipboard"] = {"missfam4", "base", "Clipboard", AnimationOptions =
   {
       Prop = 'p_amb_clipboard_01',
       PropBone = 36029,
       PropPlacement = {0.16, 0.08, 0.1, -130.0, -50.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["map"] = {"amb@world_human_tourist_map@male@base", "base", "Map", AnimationOptions =
   {
       Prop = 'prop_tourist_map_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteMoving = true,
       EmoteLoop = true
   }},
   ["beg"] = {"amb@world_human_bum_freeway@male@base", "base", "Beg", AnimationOptions =
   {
       Prop = 'prop_beggers_sign_03',
       PropBone = 58868,
       PropPlacement = {0.19, 0.18, 0.0, 5.0, 0.0, 40.0},
       EmoteLoop = true,
       EmoteMoving = true,
   }},
   ["makeitrain"] = {"anim@mp_player_intupperraining_cash", "idle_a", "Make It Rain", AnimationOptions =
   {
       Prop = 'prop_anim_cash_pile_01',
       PropBone = 60309,
       PropPlacement = {0.0, 0.0, 0.0, 180.0, 0.0, 70.0},
       EmoteMoving = true,
       EmoteLoop = true,
       PtfxAsset = "scr_xs_celebration",
       PtfxName = "scr_xs_money_rain",
       PtfxPlacement = {0.0, 0.0, -0.09, -80.0, 0.0, 0.0, 1.0},
       --PtfxInfo = Config.Languages[Config.MenuLanguage]['makeitrain'],
       PtfxWait = 500,
   }},
   ["camera"] = {"amb@world_human_paparazzi@male@base", "base", "Camera", AnimationOptions =
   {
       Prop = 'prop_pap_camera_01',
       PropBone = 28422,
       PropPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0},
       EmoteLoop = true,
       EmoteMoving = true,
       PtfxAsset = "scr_bike_business",
       PtfxName = "scr_bike_cfid_camera_flash",
       PtfxPlacement = {0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0},
       --PtfxInfo = Config.Languages[Config.MenuLanguage]['camera'],
       PtfxWait = 200,
   }},
}