print("========================")
print(" 国际象棋 AI 引擎 ")
print("========================")


local AIColor = "白方"
-- 改这里:
-- "白方" 或 "黑方"



local PieceValue = {

	["白兵"]=100,
	["黑兵"]=100,

	["白后"]=900,
	["黑后"]=900,

	["白王"]=9999,
	["黑王"]=9999

}



local Board = {

	E1="白王",
	D1="白后",
	E2="白兵",

	E8="黑王",
	D8="黑后",
	E7="黑兵"

}



local Moves = {}



local function AddMove(move,score)

	table.insert(Moves,{
		move=move,
		score=score
	})

end



print("AI颜色:")
print(AIColor)

print("")
print("棋盘读取完成")



local function IsMyPiece(piece)

	if AIColor=="白方" then
		
		return string.sub(piece,1,3)=="白"

	else
		
		return string.sub(piece,1,3)=="黑"

	end

end



print("")
print("生成走法...")


for pos,piece in pairs(Board) do


	if IsMyPiece(piece) then


		if string.find(piece,"兵") then

			AddMove(
				pos.." -> 兵移动",
				PieceValue[piece]
			)


		elseif string.find(piece,"后") then

			AddMove(
				pos.." -> 后移动",
				PieceValue[piece]
			)


		elseif string.find(piece,"王") then

			AddMove(
				pos.." -> 王移动",
				PieceValue[piece]
			)

		end


	end


end



print("")
print("AI候选走法:")



for i,data in ipairs(Moves) do

	print(
		i,
		data.move,
		"评分:",
		data.score
	)

end



print("")
print("AI计算中...")


local BestMove=""
local BestScore=-1



for _,data in ipairs(Moves) do

	if data.score>BestScore then

		BestScore=data.score
		BestMove=data.move

	end

end



print("")
print("最佳走法:")
print(BestMove)

print("评分:")
print(BestScore)



print("")
print("========================")
print("引擎运行完成")
print("========================")
