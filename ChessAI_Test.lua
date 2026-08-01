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


if Board.E2 == "白兵" then
	
	table.insert(Moves, {
		move = "E2 -> E3",
		score = 10
	})

	table.insert(Moves, {
		move = "E2 -> E4",
		score = 30
	})

end



print("")
print("可用走法:")


for i,data in ipairs(Moves) do
	
	print(
		i,
		data.move,
		"评分:",
		data.score
	)

end



print("")
print("AI评估中...")


local BestMove = nil
local BestScore = -999


for _,data in ipairs(Moves) do
	
	if data.score > BestScore then
		
		BestScore = data.score
		BestMove = data.move
		
	end

end



print("")
print("最佳走法:")
print(BestMove)

print("最高评分:")
print(BestScore)



print("")
print("========================")
print("引擎运行完成")
print("========================")
