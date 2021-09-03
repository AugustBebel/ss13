/datum/event/money_lotto
	var/winner_name = "John Smith"
	var/winner_sum = 0
	var/deposit_success = 0

/datum/event/money_lotto/start()
	winner_sum = pick(5000, 10000, 50000, 100000, 500000, 1000000, 1500000)
	if(GLOB.all_money_accounts.len)
		var/datum/money_account/D = pick(GLOB.all_money_accounts)
		winner_name = D.owner_name

		D.credit(winner_sum, "Победитель!", "Biesel TCD Терминал #[rand(111,333)]", "Nyx Daily — Сотрясяющая Звёзды Лотерея!")
		deposit_success = 1

/datum/event/money_lotto/announce()
	var/datum/feed_message/newMsg = new /datum/feed_message
	newMsg.author = "Редактор Nanotrasen"
	newMsg.admin_locked = TRUE

	newMsg.body = "Nyx Daily хочет поблагодарить [winner_name] за участие в Сотрясяющей Звёзды Лотерее от Nyx Daily, и поздравить с грандиозным выигрышем в размере [winner_sum] кредитов!"
	if(!deposit_success)
		newMsg.body += "К сожалению, мы не смогли подтвердить предоставленные данные учетной записи, поэтому мы не смогли перевести деньги. Пошлите чек в размере $500 в офис  «Сотрясяющей Звёзды Лотереи LTD» во врата Nyx с дополнительными деталями и ваш выигрыш будет доставлен вам в течении месяца."

	GLOB.news_network.get_channel_by_name("Nyx Daily")?.add_message(newMsg)
	for(var/nc in GLOB.allNewscasters)
		var/obj/machinery/newscaster/NC = nc
		NC.alert_news("Nyx Daily")
