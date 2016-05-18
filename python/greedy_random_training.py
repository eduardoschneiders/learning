#!/usr/bin/env python
# _*_ encoding: utf-8 _*
import random
import math

def black_box(x, long_term = [2, 4, 6]):
  # 2x**2 + 4x + 6
  return long_term[0]*x**2 + long_term[1]*x + long_term[2]


def training_set(range_training):
  training_data = {}
  for input in range_training:
    ideal = black_box(input)
    training_data[input] = ideal

  return training_data

def rand_ltm():
  ltm = []
  for i in range(0,3):
    ltm.append(random.randrange(1, 30))

  return ltm

def calculate_score(ltm, range_training, training_set):
  score = 0

  for i in range_training:
    output = black_box(i, ltm)
    ideal = training_set[i]
    diff = math.fabs(output - ideal)
    score += diff**2

  return math.sqrt(score/100)

def iterations():
  range_training = range(-50, 50)
  best = { 'ltm': [], 'score': None }

  for iteration in range(0, 1000000):
    ltm = rand_ltm()
    score = calculate_score(ltm, range_training, training_set(range_training))

    if (best['score'] is None or score < best['score']):
      best['ltm'] = ltm
      best['score'] = score

    print (str(iteration) + \
          ' -> LTM: ' + str(ltm) + ' Score: ' + str(score) + \
          ' Best -->> LTM: ' + str(best['ltm']) + ' Score: ' + str(best['score']) + \
          ' ======  Result: ' + str(black_box(15, ltm)) + ' Ideal: ' + str(black_box(15)))

    if (score == 0):
      break

iterations()
