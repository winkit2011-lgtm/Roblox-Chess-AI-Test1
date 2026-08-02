print("========================")
print(" 国际象棋 AI 引擎 ")
print("========================")


local AIColor="白方"



local PieceValue={

	["白兵"]=100,
	["黑兵"]=100,

	["白马"]=300,
	["黑马"]=300,

	["白象"]=300,
	["黑象"]=300,

	["白车"]=500,
	["黑车"]=500,

	["白后"]=900,
	["黑后"]=900,

	["白王"]=9999,
	["黑王"]=9999

}



local Board={

	E1="白王",
	D1="白后",
	E2="白兵",
	B1="白马",
	C1="白象",
	A1="白车",

	E8="黑王",
	D8="黑后",
	E7="黑兵",
	G8="黑马",
	C8="黑象",
	A8="黑车"

}



local Moves={}

local function MakeMove(from,to)

	local piece=Board[from]

	if piece~=nil then

		Board[from]=nil

		Board[to]=piece

	end

end


local function GetPieceAt(position)

	return Board[position]

end



local function AddMove(move,score)

	table.insert(Moves,{
		move=move,
		score=score
	})

end



local function LineMove(pos,dirs)

	local result={}

	local f=string.byte(string.sub(pos,1,1))
	local r=tonumber(string.sub(pos,2,2))


	for _,d in ipairs(dirs) do

		local nf=f+d[1]
		local nr=r+d[2]


		while nf>=65 and nf<=72
		and nr>=1 and nr<=8 do


			table.insert(
				result,
				string.char(nf)..nr
			)


			nf=nf+d[1]
			nr=nr+d[2]

		end

	end


	return result

end



local function RookMove(pos)

	return LineMove(pos,{
		{1,0},
		{-1,0},
		{0,1},
		{0,-1}
	})

end



local function BishopMove(pos)

	return LineMove(pos,{
		{1,1},
		{1,-1},
		{-1,1},
		{-1,-1}
	})

end



local function QueenMove(pos)

	local result={}


	for _,m in ipairs(RookMove(pos)) do

		table.insert(result,m)

	end


	for _,m in ipairs(BishopMove(pos)) do

		table.insert(result,m)

	end


	return result

end



local function KingMove(pos)

	local result={}

	local f=string.byte(string.sub(pos,1,1))
	local r=tonumber(string.sub(pos,2,2))


	local dirs={

		{1,0},
		{-1,0},
		{0,1},
		{0,-1},

		{1,1},
		{1,-1},
		{-1,1},
		{-1,-1}

	}


	for _,d in ipairs(dirs) do

		local nf=f+d[1]
		local nr=r+d[2]


		if nf>=65 and nf<=72
		and nr>=1 and nr<=8 then


			table.insert(
				result,
				string.char(nf)..nr
			)

		end

	end


	return result

end



local function ScoreMove(piece,target)

	local score=PieceValue[piece]


	local capture=GetPieceAt(target)


	if capture~=nil then

		score=score+PieceValue[capture]

	end


	return score

end



local function IsMyPiece(piece)

	if AIColor=="白方" then

		return string.sub(piece,1,3)=="白"

	else

		return string.sub(piece,1,3)=="黑"

	end

end



print("AI颜色:")
print(AIColor)

print("")
print("棋盘读取完成")


print("")
print("生成走法...")



for pos,piece in pairs(Board) do


	if IsMyPiece(piece) then


		local targets={}


		if string.find(piece,"后") then

			targets=QueenMove(pos)


		elseif string.find(piece,"车") then

			targets=RookMove(pos)


		elseif string.find(piece,"象") then

			targets=BishopMove(pos)


		elseif string.find(piece,"王") then

			targets=KingMove(pos)


		end



		for _,t in ipairs(targets) do

			AddMove(
				pos.." -> "..t,
				ScoreMove(piece,t)
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

print("最终评分:")
print(BestScore)
print("")

local from=string.sub(BestMove,1,2)
local to=string.sub(BestMove,7,8)


print("执行走法:")
print(from.." -> "..to)



MakeMove(
	from,
	to
)



print("")
print("更新后的棋盘:")


for pos,piece in pairs(Board) do

	print(
		pos,
		piece
	)

end


print("")
print("========================")
print("引擎运行完成")
print("========================")
