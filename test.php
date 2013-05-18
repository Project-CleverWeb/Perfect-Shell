<?php
// simple test for the question and answer system

//$qs = array(
//	"whats you fav color?",
//	'how old are you?'
//);
//$a = array();

//$i = 1;
//foreach($qs as $key => $q){
//	$qo = $i.') '.$q.' ';
//	$input = substr(fgets(STDIN),0,-1);
//	$a[$i]['q'] = $q;
//	$a[$i]['a'] = $input;
//	
//	if($i>1){
//		$c1 = strlen($qs[($key-1)]);
//		$c2 = strlen($a[($i-1)]['a']);
//		$c3 = strlen($qo);
//		$slen = ($c1+$c2-$c3);
//		
//	}
//	
//	echo "\r";
//	$i++;
//}
//echo 'ANSWERS:'.PHP_EOL;

//echo json_encode($a,PRETTY_PRINT);

function replaceOut($str){
	if(stripos($str, "\n")){
		$lines = explode("\n",$str);
	}
	else{
		$lines = array($str);
	}
	echo chr(27)."[0G"; // Set cursor to first column
	echo $str;
	if(count($lines)>1){
		echo chr(27) . "[" . (count($lines)-1) ."A"; // Set cursor up x lines
	}
}

$i2 = 1;
while($i2<21){
	$i = 0;
	while ($i<21) {
		$output = "loading script: $i2%s".($i*5)."%s [\033[96m" .str_repeat("#",$i)."\033[0m".str_repeat('#', (20-$i)). "]";
		$len = strlen($output);
		$output = sprintf($output,str_repeat(' ', (80-$len)),'%');
		replaceOut($output);
		usleep(200000);
		$i++;
	}
	$i2++;
	
	echo chr(27) . "[0G";
}


















