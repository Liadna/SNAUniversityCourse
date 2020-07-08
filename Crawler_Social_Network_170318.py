import urllib
import time
import os

def crawlSiteData():
    userhome = os.path.expanduser('~')
    desktop = userhome + '/Desktop/'
    fileNameAll = desktop + '/AllFootballResults.csv'
    dic = {}
    with open(fileName,'w') as fid:
        fid.write("Wins" + ',' + "Loses" + '\n')
    with open(fileNameAll,'w') as fid:
        fid.write("HomeTeam" + ',' + "AwayTeam" + ',' + "HomeTeamGoals" + ',' + "AwayTeamGoals" + ',' + "Date" + '\n')
    num = 85
    while (int(num)<=220):
        print ("Those are the new games after receiving team " + str(num))
        link = "http://api.football-data.org/v1/teams/" + str(num) + "/fixtures/"
        try:
            f = urllib.urlopen(link)
            json = f.read()
        except:
            num = int(num) + 1
        games = str(json).split("_links")
        i = 0
        for game in games:
            if int(i)>1:
                home = game.split('homeTeamName')[1].split('",')[0].replace('":"',"").replace("1. ","")
                away = game.split('awayTeamName')[1].split('",')[0].replace('":"', "").replace("1. ","")
                homeGoles = game.split('goalsHomeTeam')[1].split(',')[0].replace('":', "")
                awayGoles = game.split('goalsAwayTeam')[1].split(',')[0].replace('":', "").replace('}', "")
                datematch = game.split('date')[1].split('",')[0].replace('":"', "").replace('Z', "").replace('T', " ")
                with open(fileNameAll, 'a') as fidAll:
                    fidAll.write(home + ',' + away + ',' + homeGoles + ',' + awayGoles + ',' + datematch + '\n')
                if ((not('null' in homeGoles)) and (not('null' in awayGoles))):
                    homeGoles = int(homeGoles)
                    awayGoles = int(awayGoles)
                    if (homeGoles>awayGoles):
                        temp = home + "_" + away
                        if not(temp in dic):
                            dic.update({temp:1})
                            with open(fileName,'a') as fid:
                                fid.write(home + ',' + away + '\n')
                            print temp
                    elif (homeGoles<awayGoles):
                        temp = away + "_" + home
                        if not (temp in dic):
                            dic.update({temp: 1})
                            with open(fileName,'a') as fid:
                                fid.write(away + ',' + home + '\n')
                            print temp
            i = int(i) + 1
        num = int(num) + 1
        print ("Team " + str(num) + " is coming soon")
        time.sleep(5)
    print "The Crawling finished"


def createGraphData():
    dict_games = {}
    with open('AllFootballResults.csv', 'r') as fid:
        for line in fid:
            team1 = line.split(',')[0]
            if team1 == 'HomeTeam':
                continue
            team2 = line.split(',')[1]
            team1goals = int(line.split(',')[2])
            team2goals = int(line.split(',')[3])
            str1 = team1 + '@' + team2
            str2 = team2 + '@' + team1
            if str1 in dict_games and str2 in dict_games:
                dict_games[str1] += team1goals
                dict_games[str2] += team2goals
            else:
                dict_games[str1] = team1goals
                dict_games[str2] = team2goals
    with open('GoalsGraph.csv', 'w') as fid:
        fid.write('Team1,Team2,Goals\n')
    with open('GoalsGraph.csv', 'a') as fid:
        for i in dict_games:
            fid.write(str(i).split('@')[0]+','+str(i).split('@')[1]+','+str(dict_games[i]) +'\n')
#crawlSiteData()
createGraphData()