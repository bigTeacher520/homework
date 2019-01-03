#! /bin/bash
readonly snakeBody='x'       #定义蛇身
readonly snakeHead='H'		 #定义蛇头
readonly wall='m'			 #定义墙体
readonly spac='.'			 #定义空隙
readonly snakeFood='F'		 #定义食物
map_length=20				 #墙长
map_width=20				 #墙宽
snake_begin=(28 29 30)		 #蛇的位置
snake_length=3               #蛇的长度
judge_return=0               #蛇下一步的情况的返回
snake_return=0               #蛇走下一步后的返回
var=0                        #一个变量
source_x=0                   #蛇头的x坐标位置
source_y=0                   #蛇头的y坐标位置
food_pos=51                  #食物的位置
#map=($wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall 
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $wall $wall $wall $wall $spac $spac $spac $spac $wall $wall $wall $wall $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $wall $spac $spac $spac $spac $wall $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $wall $wall $wall $wall $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
#	 $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall
#	 )
map=($wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall 
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $spac $wall
	 $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall $wall
	 )
printMap(){
echo 
	for((i=0;i<map_length;i++)); do
		for((j=0;j<map_width;j++));do
			echo -e ${map[i*$map_length+j]} "\c"
			#printf "%c" ${map[i*$map_length+j]}
		done
		echo
	done
}
readOption(){
	read want
	case $want in
		'q')
			snake_return=0
		;;
		'w')
			snakeMove -1 0
		;;
		's')
			snakeMove 1 0
		;;
		'a')
			snakeMove 0 -1
		;;
		'd')
			snakeMove 0 1
		;;
		'x')
			auto_move
		;;
		*)
			echo 'please input char w,s,a,d,q,x'
			snake_return=-1;
		;;
	esac
}
auto_move(){
		while [[ 1 ]];do
			#clear
			var=$(($snake_length-1));
			source_y=$((${snake_begin[$var]} / $map_length));
			source_x=$((${snake_begin[$var]} % $map_length));
			snake_return=0
			mapGenerator
#			echo -e "score:" "$score \n" "w -up  ---s -down  ---a -left  ---d -right  ---q -exit  ---x -thoughtful snake"
			#"please input w,a,s,d to operate the snake and then press enter!! \n Or you can press q to exit "
			printMap
			food_y=$(($food_pos / $map_length));
			food_x=$(($food_pos % $map_length));
			where_x=0;
			where_y=0;
#			echo "$food_pos $food_y $food_x"
			if test $food_y -lt $source_y
				then
				judge $source_x $(($source_y-1)) 
				if test $judge_return -eq 0
					then
						if test $food_x -ge $source_x
							then
								judge $(($source_x+1)) $source_y
								if test $judge_return -eq 0
									then
										judge $source_x $(($source_y+1))
										if test $judge_return -eq 0
											then
												judge $(($source_x-1)) $source_y
												if test $judge_return -eq 0
													then
														break;
												else
													where_x=-1
													where_y=0;
												fi
										else
											where_x=0
											where_y=1
										fi
								else
									where_x=1
									where_y=0
								fi
						else
							judge $(($source_x-1)) $source_y
							if test $judge_return -eq 0
								then
									judge $source_x $(($source_y+1))
									if test $judge_return -eq 0
										then
											judge $(($source_x+1)) $source_y
											if test $judge_return -eq 0
												then
													break;
											else
												where_x=1
												where_y=0;
											fi
									else
										where_x=0
										where_y=1
									fi
							else
								where_x=-1
								where_y=0
							fi
						fi
				else
					where_y=-1
					where_x=0
				fi
			elif test $food_y -eq $source_y
				then
					if test $food_x -ge $source_x
						then
							judge $(($source_x+1)) $source_y
							if test $judge_return -eq 0
								then
									judge $source_x $(($source_y+1))
									if test $judge_return -eq 0
										then
											judge $source_x $(($source_y-1))
											if test $judge_return -eq 0
												then
													judge $(($source_x-1)) $source_y
													if test $judge_return -eq 0
														then
															break;
													else
														where_x=-1
														where_y=0;
													fi
											else
												where_x=0
												where_y=-1
											fi
									else
										where_x=0
										where_y=1
									fi
							else
								where_x=1
								where_y=0
							fi
					else
						judge $(($source_x-1)) $source_y
						if test $judge_return -eq 0
							then
								judge $source_x $(($source_y+1))
								if test $judge_return -eq 0
									then
										judge $source_x $(($source_y-1))
										if test $judge_return -eq 0
											then
												judge $(($source_x+1)) $source_y
												if test $judge_return -eq 0
													then
														break;
												else
													where_x=1
													where_y=0;
												fi
										else
											where_x=0
											where_y=-1
										fi
								else
									where_x=0
									where_y=1
								fi
						else
							where_x=-1
							where_y=0
						fi
					fi
			else
#				echo "$(($source_y+1)) $source_x"
				judge $source_x $(($source_y+1)) 
				if test $judge_return -eq 0
					then
						if test $food_x -ge $source_x
							then
								judge $(($source_x+1)) $source_y
								if test $judge_return -eq 0
									then
										judge $source_x $(($source_y-1))
										if test $judge_return -eq 0
											then
												judge $(($source_x-1)) $source_y
												if test $judge_return -eq 0
													then
														break;
												else
													where_x=-1
													where_y=0;
												fi
										else
											where_x=0
											where_y=-1
										fi
								else
									where_x=1
									where_y=0
								fi
						else
							judge $(($source_x-1)) $source_y
							if test $judge_return -eq 0
								then
									judge $source_x $(($source_y-1))
									if test $judge_return -eq 0
										then
											judge $(($source_x+1)) $source_y
											if test $judge_return -eq 0
												then
													break;
											else
												where_x=1
												where_y=0;
											fi
									else
										where_x=0
										where_y=-1
									fi
							else
								where_x=-1
								where_y=0
							fi
						fi
				else
					where_y=1
					where_x=0
				fi
			fi
#			echo "$where_y $where_x"
			snakeMove $where_y $where_x
			if test $snake_return -eq 1
				then 
				foodGenerator
			fi
			clear
		done
		snake_return=0
}
judge(){
	x=$1;
	y=$2;
	pos=$(($y*$map_length+$x));
#	echo "map:$x $y $pos ${map[$pos]}"
#	echo "enter judge: $x $y $pos"
	#echo $pos `$((${map[$pos]}=$snakeFood))`
	if test ${map[$pos]} = $snakeFood
	then
	#	echo "food"
		judge_return=1
	elif test ${map[$pos]} = $wall -o ${map[$pos]} = $snakeBody
	then
	#	echo "wall"
		judge_return=0
	else
	#	echo "space"
		judge_return=-1
	fi
}
snakeMove(){
	ver_move=$1;
	lev_move=$2;
#	echo $ver_move $lev_move
	go_x=$(($source_x+$lev_move));
	go_y=$(($source_y+$ver_move));
#	echo "H:" "${snake_begin[$var]}" "$map_length"
#	echo "pos:" "$source_x" "$source_y""->""$go_x" "$go_y"
	judge $go_x $go_y
	res=$judge_return
#	echo $res "res"
	if test $res == 0
	then
#		echo "break"
		snake_return=0;
	elif test $res == 1 
	then
#		echo "lengthen"
		snake_begin[snake_length]=$(($go_y*$map_length+$go_x));
		snake_length=$snake_length+1;
		snake_return=1;
	else
#		echo "move"
		for((i=0;i<$snake_length-1;i++));do
			mid=${snake_begin[i]};
			if test $i -eq 0
			then
#			echo "map"
				map[$mid]=$spac;
			fi
			snake_begin[i]=${snake_begin[i+1]};
			snake_begin[i+1]=$mid;
		done
		snake_begin[snake_length-1]=$(($go_y*$map_length+$go_x));
		snake_return=-1;
	fi
}
mapGenerator(){
	mid=$(($snake_length-1))
	for((i=0;i<$snake_length;i++));do
		if [[ $i == $mid ]];then
			map[${snake_begin[$i]}]=$snakeHead;
		else
			map[${snake_begin[$i]}]=$snakeBody;
		fi
	done
	map[$food_pos]=$snakeFood
}
foodGenerator(){
	while [[ 1 ]]; do
		num=$((RANDOM% ($map_length * $map_width) ))
		echo $num ${map[$num]} + $spac
		if test ${map[$num]} = $spac
			then
			food_pos=$num
			break
		fi
	done
}
score=0
while [[ 1 ]]; do
	var=$(($snake_length-1));
	source_y=$((${snake_begin[$var]} / $map_length));
	source_x=$((${snake_begin[$var]} % $map_length));
	snake_return=0
	mapGenerator
	echo -e "score:" "$score \n" "w -up  ---s -down  ---a -left  ---d -right  ---q -exit  ---x -thoughtful snake"
	#"please input w,a,s,d to operate the snake and then press enter!! \n Or you can press q to exit "
	printMap
	echo ${#map[*]}
	readOption
	res=$snake_return
	echo $res
	if test $res == 0
	then
		echo "your score is" $score "! Thanks for your gameing Time!"
		break;
	elif test $res == 1
	then
		score=$(($score+1))
		foodGenerator
	fi
	clear
done


#printMap