print("========================")
print(" 国际象棋 AI 引擎 ")
print("========================")


local Board = {

	E1 = "白王",
	D1 = "白后",
	E2 = "白兵",

	E8 = "黑王",
	D8 = "黑后",
	E7 = "黑兵"

}



print("棋盘读取完成")


print("")
print("生成走法...")


local Moves = {}


-- 白兵走法测试

if Board.E2 == "白兵" then
	
	table.insert(
		Moves,
		"E2 -> E3"
	)

	table.insert(
		Moves,
		"E2 -> E4"
	)

end



print("")
print("可用走法:")


for i,move in ipairs(Moves) do
	
	print(
		i,
		move
	)

end



print("")
print("AI评估中...")


local BestMove = Moves[2]


print("")
print("最佳走法:")
print(BestMove)



print("")
print("========================")
print("引擎运行完成")
print("========================")
