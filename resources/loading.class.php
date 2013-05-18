<?php
// create a loading bar in the prompt
class loading{
	private $vars;
	private $longvars;
	private $islong;
	private $items;
	private $fline;
	private $defaults;
	
	function __construct(){
		$this->islong = FALSE;
		$this->defaults = array(
			'prefix' => 'Loading Item: ',
			'suffix' => ' (1/1)',
			'fail_msg' => 'Failure at item %2%s (%3%s\%) in: %1%s',
			'stop_on_fail' => TRUE,
			'bar_len' => 20, // max of 50
			'line_len' => 80,
			'same_line' => TRUE, // attempt to append loading bar to last line of string
			'show_bar' => TRUE,
			'bar_style' => '|=>|'
		);
	}
	
	
	function session($file_name,$options=FALSE){
		$this->vars = (string) $file_name;
		// set the vars
		foreach ($this->defaults as $key => $value) {
			if(isset($options[$key])){
				$this->vars[$key] = $options[$key];
			}
			elseif($this->islong){
				$this->vars[$key] = $this->longvars[$key];
			}
			else{
				$this->vars[$key] = $value;
			}
		}
	}
	
	function long_session($options){
		$this->islong = TRUE;
		$options = (array) $options;
		// set the vars
		foreach ($defaults as $key => $value) {
			if(isset($options[$key])){
				$this->longvars[$key] = $options[$key];
			}
			else{
				$this->longvars[$key] = $value;
			}
		}
	}
	
	private function break_str($str){
		// breaks down output line into a usuable array
		$str = str_replace("\r",'',$str); // remove returns (only cause problems)
		$array = explode("\n",$str);
		// first identify lines that are too long
		$result = '';
		foreach ($array as $value) {
			// see if any line is too long
			if(strlen($value) > (int) $this->vars['line_len']){
				// do some maths, will always be 1 or larger
				$count_lines = floor((strlen($value)/(int) $this->vars['line_len']));
				while($count_lines<$i){
					// add new lines at each offset
					$result .= substr_replace($value, "\n", ((int) $this->vars['line_len'] * $i), 0);
				}
			}
		}
		// return array where all lines are within correct length
		return explode("\n",$result);
	}
	
	function info(){
		// return vars in array
	}
	
	private function mk_bar($percent){
		// determine style
		$style = (string) $this->vars['bar_style'];
		$st_len = strlen($style);
		if($st_len>2){
			$start    = $style[0];
			$end      = $style[($st_len-1)];
			$meat     = $style[1]; // the 'bar'
			$potatoes = ''; // the 'pointer'
			if($st_len>3){
				// if there is a pointer, get it
				$potatoes = substr($style,1,-1);
				if (strlen($potatoes)>5){
					$potatoes = substr($potatoes,0,5);
				}
			}
		}
		else{
			exit('bar_style MUST contain 3 or more characters!');
		}
		
		// create bar
		if($percent>100){ // prevent visual errors
			$percent = 100;
		}
		else{
			$percent = floor($percent);
		}
		if($this->vars['bar_len']>50){
			$this->vars['bar_len'] = 50;
		}
		$barlen = (int) $this->vars['bar_len'];
		
		// maths
		$percent = ($percent/100);
		$meatnum = ceil($barlen*$percent);
		$emptyspc = ($barlen-$meatnum);
		
		// sample output of 25%: |=====>               |
		$bar = $start.(str_repeat($meat,$meatnum)).$potatoes.(str_repeat(' ', $emptyspc)).$end;
		
		return $bar;
	}
	
	function display($percent,$failed=FALSE){
		// if failure, display msg
		
		// send output of current %
		
		
		
		$bar = '';
		if($this->vars['show_bar']){
			$bar = $this->mk_bar($percent);
		}
		
		
		
	}
	
	function flush($msg=FALSE){
		// show finished msg
		
		
		
		// reset all values
		
		
		
		
		
		
	}
}