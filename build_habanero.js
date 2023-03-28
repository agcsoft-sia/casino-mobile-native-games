const fs = require("fs")
const path = require("path")

function fixCommonURLInFolder(to) {
  let htmlFile = findHTMLFile(to);

  fixCommonURL(htmlFile);
}

function findHTMLFile(dir) {
  dir = path.resolve(dir, "..");
  let files = fs.readdirSync(dir);
  for (let i = 0; i < files.length; ++i) {
    let file = files[i];
    let ext = path.extname(file);
    if (ext === '.html') {
      return path.join(dir, file);
    }
  }
}

function fixCommonURL(file) {
  if (!file) {
    return;
  }
  let data = fs.readFileSync(file, 'utf8');
  data = data.split('../HBShared').join('HBShared');
  fs.writeFileSync(file, data);
}

console.log('Fix index file for Baccarat3H');
fixCommonURLInFolder('Baccarat3H/HBShared');

console.log('Fix index file for Blackjack');
fixCommonURLInFolder('Blackjack/HBShared');

console.log('Fix index file for BlackJack3H');
fixCommonURLInFolder('BlackJack3H/HBShared');

console.log('Fix index file for CaribbeanHoldem');
fixCommonURLInFolder('CaribbeanHoldem/HBShared');

console.log('Fix index file for CaribbeanStud');
fixCommonURLInFolder('CaribbeanStud/HBShared');

console.log('Fix index file for EURoulette');
fixCommonURLInFolder('EURoulette/HBShared');

console.log('Fix index file for SCBustedBank');
fixCommonURLInFolder('SCBustedBank/HBShared');

console.log('Fix index file for SCGladiatorRoyal');
fixCommonURLInFolder('SCGladiatorRoyal/HBShared');

console.log('Fix index file for SCTotemWarrior');
fixCommonURLInFolder('SCTotemWarrior/HBShared');

console.log('Fix index file for SG12Zodiacs');
fixCommonURLInFolder('SG12Zodiacs/HBShared');

console.log('Fix index file for SG5LuckyLions');
fixCommonURLInFolder('SG5LuckyLions/HBShared');

console.log('Fix index file for SG5Mariachis');
fixCommonURLInFolder('SG5Mariachis/HBShared');

console.log('Fix index file for SGAlienPlanet');
fixCommonURLInFolder('SGAlienPlanet/HBShared');

console.log('Fix index file for SGAllForOne');
fixCommonURLInFolder('SGAllForOne/HBShared');

console.log('Fix index file for SGArcaneElements');
fixCommonURLInFolder('SGArcaneElements/HBShared');

console.log('Fix index file for SGArcticWonders');
fixCommonURLInFolder('SGArcticWonders/HBShared');

console.log('Fix index file for SGAzlandsGold');
fixCommonURLInFolder('SGAzlandsGold/HBShared');

console.log('Fix index file for SGBarnstormerBucks');
fixCommonURLInFolder('SGBarnstormerBucks/HBShared');

console.log('Fix index file for SGBeforeTimeRunsOut');
fixCommonURLInFolder('SGBeforeTimeRunsOut/HBShared');

console.log('Fix index file for SGBikiniIsland');
fixCommonURLInFolder('SGBikiniIsland/HBShared');

console.log('Fix index file for SGBirdOfThunder');
fixCommonURLInFolder('SGBirdOfThunder/HBShared');

console.log('Fix index file for SGBlackbeardsBounty');
fixCommonURLInFolder('SGBlackbeardsBounty/HBShared');

console.log('Fix index file for SGBombRunner');
fixCommonURLInFolder('SGBombRunner/HBShared');

console.log('Fix index file for SGBombsAway');
fixCommonURLInFolder('SGBombsAway/HBShared');

console.log('Fix index file for SGBuggyBonus');
fixCommonURLInFolder('SGBuggyBonus/HBShared');

console.log('Fix index file for SGCakeValley');
fixCommonURLInFolder('SGCakeValley/HBShared');

console.log('Fix index file for SGCalaverasExplosivas');
fixCommonURLInFolder('SGCalaverasExplosivas/HBShared');

console.log('Fix index file for SGCandyTower');
fixCommonURLInFolder('SGCandyTower/HBShared');

console.log('Fix index file for SGCarnivalCash');
fixCommonURLInFolder('SGCarnivalCash/HBShared');

console.log('Fix index file for SGCashosaurus');
fixCommonURLInFolder('SGCashosaurus/HBShared');

console.log('Fix index file for SGCashReef');
fixCommonURLInFolder('SGCashReef/HBShared');

console.log('Fix index file for SGChristmasGiftRush');
fixCommonURLInFolder('SGChristmasGiftRush/HBShared');

console.log('Fix index file for SGColossalGems');
fixCommonURLInFolder('SGColossalGems/HBShared');

console.log('Fix index file for SGCoyoteCrash');
fixCommonURLInFolder('SGCoyoteCrash/HBShared');

console.log('Fix index file for SGCrystopia');
fixCommonURLInFolder('SGCrystopia/HBShared');

console.log('Fix index file for SGDiscoBeats');
fixCommonURLInFolder('SGDiscoBeats/HBShared');

console.log('Fix index file for SGDiscoFunk');
fixCommonURLInFolder('SGDiscoFunk/HBShared');

console.log('Fix index file for SGDoubleODollars');
fixCommonURLInFolder('SGDoubleODollars/HBShared');

console.log('Fix index file for SGDragonsRealm');
fixCommonURLInFolder('SGDragonsRealm/HBShared');

console.log('Fix index file for SGDragonsThrone');
fixCommonURLInFolder('SGDragonsThrone/HBShared');

console.log('Fix index file for SGDragonTigerGate');
fixCommonURLInFolder('SGDragonTigerGate/HBShared');

console.log('Fix index file for SGDrFeelgood');
fixCommonURLInFolder('SGDrFeelgood/HBShared');

console.log('Fix index file for SGEgyptianDreams');
fixCommonURLInFolder('SGEgyptianDreams/HBShared');

console.log('Fix index file for SGEgyptianDreamsDeluxe');
fixCommonURLInFolder('SGEgyptianDreamsDeluxe/HBShared');

console.log('Fix index file for SGFaCaiShen');
fixCommonURLInFolder('SGFaCaiShen/HBShared');

console.log('Fix index file for SGFaCaiShenDeluxe');
fixCommonURLInFolder('SGFaCaiShenDeluxe/HBShared');

console.log('Fix index file for SGFenghuang');
fixCommonURLInFolder('SGFenghuang/HBShared');

console.log('Fix index file for SGFireRooster');
fixCommonURLInFolder('SGFireRooster/HBShared');

console.log('Fix index file for SGFly');
fixCommonURLInFolder('SGFly/HBShared');

console.log('Fix index file for SGFlyingHigh');
fixCommonURLInFolder('SGFlyingHigh/HBShared');

console.log('Fix index file for SGFortuneDogs');
fixCommonURLInFolder('SGFortuneDogs/HBShared');

console.log('Fix index file for SGFourDivineBeasts');
fixCommonURLInFolder('SGFourDivineBeasts/HBShared');

console.log('Fix index file for SGFrontierFortunes');
fixCommonURLInFolder('SGFrontierFortunes/HBShared');

console.log('Fix index file for SGGalacticCash');
fixCommonURLInFolder('SGGalacticCash/HBShared');

console.log('Fix index file for SGGangsters');
fixCommonURLInFolder('SGGangsters/HBShared');

console.log('Fix index file for SGGlamRock');
fixCommonURLInFolder('SGGlamRock/HBShared');

console.log('Fix index file for SGGoldenUnicorn');
fixCommonURLInFolder('SGGoldenUnicorn/HBShared');

console.log('Fix index file for SGGoldenUnicornDeluxe');
fixCommonURLInFolder('SGGoldenUnicornDeluxe/HBShared');

console.log('Fix index file for SGGoldRush');
fixCommonURLInFolder('SGGoldRush/HBShared');

console.log('Fix index file for SGGrapeEscape');
fixCommonURLInFolder('SGGrapeEscape/HBShared');

console.log('Fix index file for SGHappiestChristmasTree');
fixCommonURLInFolder('SGHappiestChristmasTree/HBShared');

console.log('Fix index file for SGHappyApe');
fixCommonURLInFolder('SGHappyApe/HBShared');

console.log('Fix index file for SGHauntedHouse');
fixCommonURLInFolder('SGHauntedHouse/HBShared');

console.log('Fix index file for SGHeySushi');
fixCommonURLInFolder('SGHeySushi/HBShared');

console.log('Fix index file for SGHotHotFruit');
fixCommonURLInFolder('SGHotHotFruit/HBShared');

console.log('Fix index file for SGHotHotHalloween');
fixCommonURLInFolder('SGHotHotHalloween/HBShared');

console.log('Fix index file for SGIndianCashCatcher');
fixCommonURLInFolder('SGIndianCashCatcher/HBShared');

console.log('Fix index file for SGJellyfishFlow');
fixCommonURLInFolder('SGJellyfishFlow/HBShared');

console.log('Fix index file for SGJugglenaut');
fixCommonURLInFolder('SGJugglenaut/HBShared');

console.log('Fix index file for SGJump');
fixCommonURLInFolder('SGJump/HBShared');

console.log('Fix index file for SGJungleRumble');
fixCommonURLInFolder('SGJungleRumble/HBShared');

console.log('Fix index file for SGKanesInferno');
fixCommonURLInFolder('SGKanesInferno/HBShared');

console.log('Fix index file for SGKingTutsTomb');
fixCommonURLInFolder('SGKingTutsTomb/HBShared');

console.log('Fix index file for SGKnockoutFootball');
fixCommonURLInFolder('SGKnockoutFootball/HBShared');

console.log('Fix index file for SGKnockoutFootballRush');
fixCommonURLInFolder('SGKnockoutFootballRush/HBShared');

console.log('Fix index file for SGLanternLuck');
fixCommonURLInFolder('SGLanternLuck/HBShared');

console.log('Fix index file for SGLaughingBuddha');
fixCommonURLInFolder('SGLaughingBuddha/HBShared');

console.log('Fix index file for SGLegendaryBeasts');
fixCommonURLInFolder('SGLegendaryBeasts/HBShared');

console.log('Fix index file for SGLegendOfNezha');
fixCommonURLInFolder('SGLegendOfNezha/HBShared');

console.log('Fix index file for SGLittleGreenMoney');
fixCommonURLInFolder('SGLittleGreenMoney/HBShared');

console.log('Fix index file for SGLondonHunter');
fixCommonURLInFolder('SGLondonHunter/HBShared');

console.log('Fix index file for SGLoonyBlox');
fixCommonURLInFolder('SGLoonyBlox/HBShared');

console.log('Fix index file for SGLuckyDurian');
fixCommonURLInFolder('SGLuckyDurian/HBShared');

console.log('Fix index file for SGLuckyFortuneCat');
fixCommonURLInFolder('SGLuckyFortuneCat/HBShared');

console.log('Fix index file for SGLuckyLucky');
fixCommonURLInFolder('SGLuckyLucky/HBShared');

console.log('Fix index file for SGMagicOak');
fixCommonURLInFolder('SGMagicOak/HBShared');

console.log('Fix index file for SGMarvelousFurlongs');
fixCommonURLInFolder('SGMarvelousFurlongs/HBShared');

console.log('Fix index file for SGMightyMedusa');
fixCommonURLInFolder('SGMightyMedusa/HBShared');

console.log('Fix index file for SGMonsterMashCash');
fixCommonURLInFolder('SGMonsterMashCash/HBShared');

console.log('Fix index file for SGMountMazuma');
fixCommonURLInFolder('SGMountMazuma/HBShared');

console.log('Fix index file for SGMrBling');
fixCommonURLInFolder('SGMrBling/HBShared');

console.log('Fix index file for SGMummyMoney');
fixCommonURLInFolder('SGMummyMoney/HBShared');

console.log('Fix index file for SGMysticFortune');
fixCommonURLInFolder('SGMysticFortune/HBShared');

console.log('Fix index file for SGMysticFortuneDeluxe');
fixCommonURLInFolder('SGMysticFortuneDeluxe/HBShared');

console.log('Fix index file for SGNaughtySanta');
fixCommonURLInFolder('SGNaughtySanta/HBShared');

console.log('Fix index file for SGNaughtyWukong');
fixCommonURLInFolder('SGNaughtyWukong/HBShared');

console.log('Fix index file for SGNewYearsBash');
fixCommonURLInFolder('SGNewYearsBash/HBShared');

console.log('Fix index file for SGNineTails');
fixCommonURLInFolder('SGNineTails/HBShared');

console.log('Fix index file for SGNuwa');
fixCommonURLInFolder('SGNuwa/HBShared');

console.log('Fix index file for SGOceansCall');
fixCommonURLInFolder('SGOceansCall/HBShared');

console.log('Fix index file for SGOrbsOfAtlantis');
fixCommonURLInFolder('SGOrbsOfAtlantis/HBShared');

console.log('Fix index file for SGPamperMe');
fixCommonURLInFolder('SGPamperMe/HBShared');

console.log('Fix index file for SGPandaPanda');
fixCommonURLInFolder('SGPandaPanda/HBShared');

console.log('Fix index file for SGPiratesPlunder');
fixCommonURLInFolder('SGPiratesPlunder/HBShared');

console.log('Fix index file for SGPoolShark');
fixCommonURLInFolder('SGPoolShark/HBShared');

console.log('Fix index file for SGPresto');
fixCommonURLInFolder('SGPresto/HBShared');

console.log('Fix index file for SGProst');
fixCommonURLInFolder('SGProst/HBShared');

console.log('Fix index file for SGPuckerUpPrince');
fixCommonURLInFolder('SGPuckerUpPrince/HBShared');

console.log('Fix index file for SGPumpkinPatch');
fixCommonURLInFolder('SGPumpkinPatch/HBShared');

console.log('Fix index file for SGQueenOfQueens1024');
fixCommonURLInFolder('SGQueenOfQueens1024/HBShared');

console.log('Fix index file for SGQueenOfQueens243');
fixCommonURLInFolder('SGQueenOfQueens243/HBShared');

console.log('Fix index file for SGRainbowmania');
fixCommonURLInFolder('SGRainbowmania/HBShared');

console.log('Fix index file for SGReturnToTheFeature');
fixCommonURLInFolder('SGReturnToTheFeature/HBShared');

console.log('Fix index file for SGRideEmCowboy');
fixCommonURLInFolder('SGRideEmCowboy/HBShared');

console.log('Fix index file for SGRodeoDrive');
fixCommonURLInFolder('SGRodeoDrive/HBShared');

console.log('Fix index file for SGRollingRoger');
fixCommonURLInFolder('SGRollingRoger/HBShared');

console.log('Fix index file for SGRomanEmpire');
fixCommonURLInFolder('SGRomanEmpire/HBShared');

console.log('Fix index file for SGRuffledUp');
fixCommonURLInFolder('SGRuffledUp/HBShared');

console.log('Fix index file for SGSantasVillage');
fixCommonURLInFolder('SGSantasVillage/HBShared');

console.log('Fix index file for SGScopa');
fixCommonURLInFolder('SGScopa/HBShared');

console.log('Fix index file for SGScruffyScallywags');
fixCommonURLInFolder('SGScruffyScallywags/HBShared');

console.log('Fix index file for SGShaolinFortunes100');
fixCommonURLInFolder('SGShaolinFortunes100/HBShared');

console.log('Fix index file for SGShaolinFortunes243');
fixCommonURLInFolder('SGShaolinFortunes243/HBShared');

console.log('Fix index file for SGShogunsLand');
fixCommonURLInFolder('SGShogunsLand/HBShared');

console.log('Fix index file for SGSirBlingalot');
fixCommonURLInFolder('SGSirBlingalot/HBShared');

console.log('Fix index file for SGSirensSpell');
fixCommonURLInFolder('SGSirensSpell/HBShared');

console.log('Fix index file for SGSkysTheLimit');
fixCommonURLInFolder('SGSkysTheLimit/HBShared');

console.log('Fix index file for SGSojuBomb');
fixCommonURLInFolder('SGSojuBomb/HBShared');

console.log('Fix index file for SGSOS');
fixCommonURLInFolder('SGSOS/HBShared');

console.log('Fix index file for SGSpaceFortune');
fixCommonURLInFolder('SGSpaceFortune/HBShared');

console.log('Fix index file for SGSpaceGoonz');
fixCommonURLInFolder('SGSpaceGoonz/HBShared');

console.log('Fix index file for SGSparta');
fixCommonURLInFolder('SGSparta/HBShared');

console.log('Fix index file for SGSteamExpress');
fixCommonURLInFolder('SGSteamExpress/HBShared');

console.log('Fix index file for SGSuperStrike');
fixCommonURLInFolder('SGSuperStrike/HBShared');

console.log('Fix index file for SGSuperTwister');
fixCommonURLInFolder('SGSuperTwister/HBShared');

console.log('Fix index file for SGTabernaDeLosMuertos');
fixCommonURLInFolder('SGTabernaDeLosMuertos/HBShared');

console.log('Fix index file for SGTaikoBeats');
fixCommonURLInFolder('SGTaikoBeats/HBShared');

console.log('Fix index file for SGTechnoTumble');
fixCommonURLInFolder('SGTechnoTumble/HBShared');

console.log('Fix index file for SGTheBigDeal');
fixCommonURLInFolder('SGTheBigDeal/HBShared');

console.log('Fix index file for SGTheBigDealDeluxe');
fixCommonURLInFolder('SGTheBigDealDeluxe/HBShared');

console.log('Fix index file for SGTheDeadEscape');
fixCommonURLInFolder('SGTheDeadEscape/HBShared');

console.log('Fix index file for SGTheDragonCastle');
fixCommonURLInFolder('SGTheDragonCastle/HBShared');

console.log('Fix index file for SGTheKoiGate');
fixCommonURLInFolder('SGTheKoiGate/HBShared');

console.log('Fix index file for SGTootyFruityFruits');
fixCommonURLInFolder('SGTootyFruityFruits/HBShared');

console.log('Fix index file for SGTotemTowers');
fixCommonURLInFolder('SGTotemTowers/HBShared');

console.log('Fix index file for SGTowerOfPizza');
fixCommonURLInFolder('SGTowerOfPizza/HBShared');

console.log('Fix index file for SGTreasureDiver');
fixCommonURLInFolder('SGTreasureDiver/HBShared');

console.log('Fix index file for SGTreasureTomb');
fixCommonURLInFolder('SGTreasureTomb/HBShared');

console.log('Fix index file for SGTukTukThailand');
fixCommonURLInFolder('SGTukTukThailand/HBShared');

console.log('Fix index file for SGVikingsPlunder');
fixCommonURLInFolder('SGVikingsPlunder/HBShared');

console.log('Fix index file for SGWaysOfFortune');
fixCommonURLInFolder('SGWaysOfFortune/HBShared');

console.log('Fix index file for SGWealthInn');
fixCommonURLInFolder('SGWealthInn/HBShared');

console.log('Fix index file for SGWeirdScience');
fixCommonURLInFolder('SGWeirdScience/HBShared');

console.log('Fix index file for SGWickedWitch');
fixCommonURLInFolder('SGWickedWitch/HBShared');

console.log('Fix index file for SGWildTrucks');
fixCommonURLInFolder('SGWildTrucks/HBShared');

console.log('Fix index file for SGWizardsWantWar');
fixCommonURLInFolder('SGWizardsWantWar/HBShared');

console.log('Fix index file for SGZeus');
fixCommonURLInFolder('SGZeus/HBShared');

console.log('Fix index file for SGZeus2');
fixCommonURLInFolder('SGZeus2/HBShared');

console.log('Fix index file for SicBo');
fixCommonURLInFolder('SicBo/HBShared');

console.log('Fix index file for TGDragonTiger');
fixCommonURLInFolder('TGDragonTiger/HBShared');

console.log('Fix index file for TGNiuNiuPoker');
fixCommonURLInFolder('TGNiuNiuPoker/HBShared');

console.log('Fix index file for TGRaiseItUpPoker');
fixCommonURLInFolder('TGRaiseItUpPoker/HBShared');

console.log('Fix index file for TGThreeCardPoker');
fixCommonURLInFolder('TGThreeCardPoker/HBShared');

console.log('Fix index file for TGWar');
fixCommonURLInFolder('TGWar/HBShared');

console.log('Fix index file for VideoPokerMultiHand');
fixCommonURLInFolder('VideoPokerMultiHand/HBShared');

console.log('Done.');

