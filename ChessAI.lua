-- ChessAI 棋盘测试模块

print("========================")
print(" 国际象棋 AI 棋盘加载 ")
print("========================")


local Board = {

	["A1"]="白车",
	["B1"]="白马",
	["C1"]="白象",
	["D1"]="白后",
	["E1"]="白王",

	["A8"]="黑车",
	["B8"]="黑马",
	["C8"]="黑象",
	["D8"]="黑后",
	["E8"]="黑王"

}



local function ShowBoard()

	print("当前棋盘:")

	for pos,piece in pairs(Board) do

		print(
			pos,
			"=",
			piece
		)

	end

end



local function AnalyzeBoard()

	print("AI读取棋盘...")

	wait(1)

	print("发现白王位置: E1")
	print("发现黑王位置: E8")

	print("棋盘分析完成")

end



ShowBoard()

AnalyzeBoard()


print("========================")
print("棋盘模块启动完成")
print("========================")
