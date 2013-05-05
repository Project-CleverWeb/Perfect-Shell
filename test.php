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
	$numNewLines = substr_count($str, "\n");
	echo chr(27)."[0G"; // Set cursor to first column
	echo $str;
	if($numNewLines>0){
		echo chr(27) . "[" . $numNewLines ."A"; // Set cursor up x lines
	}
}

$i2 = 0;
while($i2<6){
	$i = 0;
	while ($i<21) {
		$output = "loading script: $i2%s".($i*5)."[" .str_repeat('#',$i).str_repeat(' ', (20-$i)). "]";
		$len = strlen($output);
		$output = sprintf($output,str_repeat(' ', (80-$len)));
		replaceOut($output);
		usleep(200000);
		$i++;
	}
	$i2++;
	
	echo chr(27) . "[0G";
	echo str_repeat(' ', 80);
}


















