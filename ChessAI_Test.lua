print("========================")
print(" 国际象棋 AI 引擎 ")
print("========================")


------------------------------------------------
-- AI设置
------------------------------------------------

-- 改这里：
-- "白方" 或 "黑方"

local AIColor="白方"



local EnemyColor

if AIColor=="白方" then
	EnemyColor="黑方"
else
	EnemyColor="白方"
end



------------------------------------------------
-- 棋子价值
------------------------------------------------

local PieceValue={

	["白兵"]=100,
	["黑兵"]=100,

	["白马"]=320,
	["黑马"]=320,

	["白象"]=330,
	["黑象"]=330,

	["白车"]=500,
	["黑车"]=500,

	["白后"]=900,
	["黑后"]=900,

	["白王"]=9999,
	["黑王"]=9999

}



------------------------------------------------
-- 初始棋盘
------------------------------------------------

local Board={


	-- 白方

	A1="白车",
	B1="白马",
	C1="白象",
	D1="白后",
	E1="白王",

	A2="白兵",
	B2="白兵",
	C2="白兵",
	D2="白兵",
	E2="白兵",



	-- 黑方

	A8="黑车",
	B8="黑马",
	C8="黑象",
	D8="黑后",
	E8="黑王",

	A7="黑兵",
	B7="黑兵",
	C7="黑兵",
	D7="黑兵",
	E7="黑兵"


}



------------------------------------------------
-- 基础判断
------------------------------------------------


local function GetColor(piece)

	if piece==nil then
		return nil
	end


	return piece:sub(1,3)

end



local function IsAI(piece)

	return GetColor(piece)==AIColor

end



local function IsEnemy(piece)

	return GetColor(piece)==EnemyColor

end



------------------------------------------------
-- 复制棋盘
------------------------------------------------


local function CopyBoard()

	local copy={}


	for pos,piece in pairs(Board) do

		copy[pos]=piece

	end


	return copy

end



------------------------------------------------
-- 移动棋子
------------------------------------------------


local function MakeMove(from,to)

	local piece=Board[from]


	if piece then

		Board[to]=piece

		Board[from]=nil

	end


end



------------------------------------------------
-- 恢复棋盘
------------------------------------------------


local function RestoreBoard(old)


	for k in pairs(Board) do

		Board[k]=nil

	end



	for k,v in pairs(old) do

		Board[k]=v

	end


end



------------------------------------------------
-- 文件第1部分结束
------------------------------------------------
------------------------------------------------
-- 移动合法检查
------------------------------------------------

local function CanMove(piece,to)


	local target=Board[to]


	-- 空格可以走

	if target==nil then

		return true

	end



	-- 不能吃自己的棋

	if GetColor(target)==GetColor(piece) then

		return false

	end



	-- 可以吃敌棋

	return true

end



------------------------------------------------
-- 添加走法
------------------------------------------------


local function AddMove(list,from,to)


	local piece=Board[from]


	if piece==nil then
		return
	end



	if CanMove(piece,to) then


		table.insert(
			list,
			{
				from=from,
				to=to
			}
		)


	end


end



------------------------------------------------
-- 直线移动
-- 车、象、后
------------------------------------------------


local function LineMove(pos,directions)


	local result={}


	local file=string.byte(pos:sub(1,1))
	local rank=tonumber(pos:sub(2,2))



	for _,d in ipairs(directions) do


		local f=file+d[1]
		local r=rank+d[2]



		while f>=65 and f<=72
		and r>=1 and r<=8 do


			table.insert(
				result,
				string.char(f)..r
			)


			f=f+d[1]
			r=r+d[2]


		end


	end


	return result

end



------------------------------------------------
-- 车
------------------------------------------------


local function RookMove(pos)

	return LineMove(
		pos,
		{
			{1,0},
			{-1,0},
			{0,1},
			{0,-1}
		}
	)

end



------------------------------------------------
-- 象
------------------------------------------------


local function BishopMove(pos)

	return LineMove(
		pos,
		{
			{1,1},
			{1,-1},
			{-1,1},
			{-1,-1}
		}
	)

end



------------------------------------------------
-- 后
------------------------------------------------


local function QueenMove(pos)


	return LineMove(
		pos,
		{

			{1,0},
			{-1,0},
			{0,1},
			{0,-1},

			{1,1},
			{1,-1},
			{-1,1},
			{-1,-1}

		}
	)

end



------------------------------------------------
-- 王
------------------------------------------------


local function KingMove(pos)


	local result={}


	local f=string.byte(pos:sub(1,1))
	local r=tonumber(pos:sub(2,2))



	for x=-1,1 do

		for y=-1,1 do


			if x~=0 or y~=0 then


				local nf=f+x
				local nr=r+y



				if nf>=65 and nf<=72
				and nr>=1 and nr<=8 then


					table.insert(
						result,
						string.char(nf)..nr
					)


				end


			end


		end

	end


	return result

end



------------------------------------------------
-- 马
------------------------------------------------


local function KnightMove(pos)


	local result={}


	local f=string.byte(pos:sub(1,1))
	local r=tonumber(pos:sub(2,2))



	local steps={

		{1,2},
		{2,1},
		{2,-1},
		{1,-2},

		{-1,-2},
		{-2,-1},
		{-2,1},
		{-1,2}

	}



	for _,s in ipairs(steps) do


		local nf=f+s[1]
		local nr=r+s[2]



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



------------------------------------------------
-- 兵
------------------------------------------------


local function PawnMove(pos,piece)


	local result={}


	local file=pos:sub(1,1)
	local rank=tonumber(pos:sub(2,2))


	local direction=1


	if GetColor(piece)=="黑方" then

		direction=-1

	end



	local newRank=rank+direction



	if newRank>=1 and newRank<=8 then


		table.insert(
			result,
			file..newRank
		)


	end


	return result

end
------------------------------------------------
-- 生成所有AI走法
------------------------------------------------

local function GenerateMoves(color)


	local moves={}



	for pos,piece in pairs(Board) do



		if GetColor(piece)==color then



			local targets={}



			if piece:find("车") then

				targets=RookMove(pos)


			elseif piece:find("象") then

				targets=BishopMove(pos)


			elseif piece:find("后") then

				targets=QueenMove(pos)


			elseif piece:find("王") then

				targets=KingMove(pos)


			elseif piece:find("马") then

				targets=KnightMove(pos)


			elseif piece:find("兵") then

				targets=PawnMove(pos,piece)


			end



			for _,to in ipairs(targets) do


				AddMove(
					moves,
					pos,
					to
				)


			end


		end


	end



	return moves

end



------------------------------------------------
-- 模拟移动
------------------------------------------------

local function SimulateMove(move)


	local old=CopyBoard()



	MakeMove(
		move.from,
		move.to
	)



	return old

end



------------------------------------------------
-- 局面评分
------------------------------------------------

local function EvaluateBoard()


	local score=0



	for _,piece in pairs(Board) do



		local value=PieceValue[piece]



		if GetColor(piece)==AIColor then


			score=score+value


		else


			score=score-value


		end


	end



	return score

end



------------------------------------------------
-- Alpha-Beta搜索
------------------------------------------------

local function AlphaBeta(depth,color,alpha,beta)


	if depth==0 then

		return EvaluateBoard()

	end



	local moves=GenerateMoves(color)



	if #moves==0 then

		return EvaluateBoard()

	end



	local maximizing



	if color==AIColor then

		maximizing=true

	else

		maximizing=false

	end



	if maximizing then



		local value=-999999



		for _,move in ipairs(moves) do



			local old=SimulateMove(move)



			local score=AlphaBeta(
				depth-1,
				EnemyColor,
				alpha,
				beta
			)



			RestoreBoard(old)



			if score>value then

				value=score

			end



			if value>alpha then

				alpha=value

			end



			if alpha>=beta then

				break

			end


		end



		return value



	else



		local value=999999



		for _,move in ipairs(moves) do



			local old=SimulateMove(move)



			local score=AlphaBeta(
				depth-1,
				AIColor,
				alpha,
				beta
			)



			RestoreBoard(old)



			if score<value then

				value=score

			end



			if value<beta then

				beta=value

			end



			if alpha>=beta then

				break

			end


		end



		return value


	end


end
------------------------------------------------
-- 寻找最佳走法
------------------------------------------------

local function FindBestMove()


	local moves=GenerateMoves(AIColor)



	local bestMove=nil

	local bestScore=-999999



	print("")
	print("AI正在计算...")
	print("候选数量:",#moves)



	for _,move in ipairs(moves) do



		local old=SimulateMove(move)



		local score=AlphaBeta(
			2,
			EnemyColor,
			-999999,
			999999
		)



		RestoreBoard(old)



		print(
			"测试:",
			move.from.." -> "..move.to,
			"评分:",
			score
		)



		if score>bestScore then


			bestScore=score

			bestMove=move


		end


	end



	return bestMove,bestScore

end



------------------------------------------------
-- 执行AI移动
------------------------------------------------

local function ExecuteAIMove()


	local move,score=FindBestMove()



	if move==nil then


		print("没有可用走法")

		return


	end



	print("")
	print("========================")
	print("AI选择:")
	print(
		move.from..
		" -> "..
		move.to
	)

	print(
		"评分:",
		score
	)

	print("========================")



	MakeMove(
		move.from,
		move.to
	)



end



------------------------------------------------
-- 显示棋盘
------------------------------------------------

local function PrintBoard()


	print("")
	print("当前棋盘:")



	for pos,piece in pairs(Board) do


		print(
			pos,
			piece
		)


	end


end



------------------------------------------------
-- 启动AI
------------------------------------------------


print("")
print("AI阵营:")
print(AIColor)



PrintBoard()



ExecuteAIMove()



PrintBoard()



print("")
print("========================")
print(" AI运行完成 ")
print("========================")
