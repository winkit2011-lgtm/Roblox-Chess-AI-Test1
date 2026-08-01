-- ChessAI Console Control

print("========================")
print(" 国际象棋 AI 控制台 ")
print("========================")


local Config = {
	Level = 5,
	Mode = "平衡",
	ThinkTime = 3
}



local function ShowConfig()

	print("----------------")
	print("当前设置")
	print("AI等级:", Config.Level)
	print("模式:", Config.Mode)
	print("思考时间:", Config.ThinkTime, "秒")
	print("----------------")

end



local function SetLevel(value)

	Config.Level = value

	print("AI等级修改为:", value)

end



local function SetMode(value)

	Config.Mode = value

	print("模式修改为:", value)

end



local function Analyze()

	print("AI分析中...")

	wait(1)

	local move = {
		from = "E2",
		to = "E4"
	}

	print(
		"最佳走法:",
		move.from,
		"->",
		move.to
	)

end



-- 启动

ShowConfig()


print("")
print("测试调整参数")


SetLevel(8)

SetMode("深度")


ShowConfig()


Analyze()


print("========================")
print("系统运行完成")
print("========================")
