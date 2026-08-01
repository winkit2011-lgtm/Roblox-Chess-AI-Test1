print("========================")
print(" 国际象棋 AI 启动 ")
print("========================")


local Config = {
	Level = 5,
	Mode = "平衡"
}


print("AI等级:", Config.Level)
print("模式:", Config.Mode)



local Board = {

	E1 = "白王",
	D1 = "白后",
	E2 = "白兵",

	E8 = "黑王",
	D8 = "黑后",
	E7 = "黑兵"

}



print("")
print("棋盘读取:")


for position, piece in pairs(Board) do
	
	print(
		piece,
		"位置:",
		position
	)

end



print("")
print("AI分析中...")

wait(1)


print("最佳走法:")
print("E2 -> E4")


print("")
print("系统运行完成")
