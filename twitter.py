#!/usr/bin/env python
# -*- coding: utf-8 -*-

#
#  Synopsis
#
#        ##
#        ###
#   #    ###
#   #   ####
#   #  #####
#  ## ######
#  #########
#  012345678
#
#  На этой картинке у нас есть стены различной высоты. Картинка представлена массивом целых чисел, 
#   где индекс — это точка на оси X, а значение каждого индекса — это высота стены (значение по оси Y). Картинке выше соответствует массив [2,5,1,2,3,4,7,7,6].
#
#  Теперь представьте: идет дождь. Сколько воды соберется в «лужах» между стенами?
#  Мы считаем единицей объема воды квадратный блок 1х1. На картинке выше все, что расположено слева от точки 1, выплескивается. Вода справа от точки 7 также прольется. 
# У нас остается лужа между 1 и 6 — таким образом, получившийся объем воды равен 10.
# link: http://habrahabr.ru/post/200190/
# link2: http://qandwhat.apps.runkite.com/i-failed-a-twitter-interview/
import pdb
import math

def calcEquilibrium(array):
	sum = 0
	for n in array:
		sum += n
	print(sum)
	i = 0
	left = 0
	right = sum
	while i < len(array):

   		
   		right -=array[i]
   		#print "index", i
   		#print "left", left
   		#print "right", right
   		if left==right:
   			return i
   		left += array[i]
		i+=1


def calcVolume(land):
	vol = max_left = max_right = i = 0
	while (i < len(land)):

		if max_left < land[i]:
			max_left = land[i]
			
		else:
			#let's find most highest right boundary
			j = i
			max_right = prev_max_right = 0
			while(j < len(land)):
				if max_right < land[j]:
					prev_max_right = max_right
					max_right = land[j]
					if max_right >= max_left:
						break
					if prev_max_right > max_right:
						max_right = prev_max_right
						break
				j += 1
			#ok found right boundary
			if land[i]<max_right:
				vol += min(max_left, max_right) - land[i]
		#print "index", i
		#print "max_left", max_left
		#print "vol", vol
		i += 1

	return vol




#print calcEquilibrium([2,5,1,2,3,4,7,7,6])
#print calcEquilibrium([-7,1,5,2,-4,3,0])
print calcVolume([2,5,1,2,3,4,7,7,6])
print calcVolume([1,2,1,5,0,1,0,2])