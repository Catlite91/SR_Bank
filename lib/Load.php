<?php

/**
 * App Framework
 * used for load files and classes
 * write by simonLau 
 * April 30, 2015
 */
class Load {

    public static $_db = array();

    /**
     * function model
     * param $file $module
     * example: 
     * (1) $file = User $module = null
     *     result loadClass("User", "User_Model", "MODEL_DIR")
     * (2) $file = User $module = Web
     *     result loadClass("User", "Web_User_Model","MODEL_DIR/Web")
     * 
    **/
    public static function model($file, $module = null) {
        if ($module) {
            $class = $module . '_' . $file . '_Model';
            $dir = MOD_DIR . '/' . $module;
        } else {
            $class = $file . '_Model';
            $dir = MOD_DIR;
        }
        return self::loadClass($file, $class, $dir);    
    }

    /**
     * function controller
     * param $file $module
     * example: 
     * (1) $file = User $module = null
     *     result loadClass("User", "User_Controller", "CTRL_DIR")
     * (2) $file = User $module = Web
     *     result loadClass("User", "User_Model","MODEL_DIR/Web")
     * 
    **/
    public static function controller($file, $module = null) {
        if($module){
            $class = $file . '_Controller';
            $dir = CTRL_DIR . '/' . $module;
        }else{
           $class = $file . '_Controller'; 
           $dir = CTRL_DIR;
        }
        return self::loadClass($file, $class, $dir);
    }

    public static function lib($file){
        $class = $file."_Library";
        return self::loadClass($file, $class, LIB_DIR.'/library');
    }
    /**
     *loadClass function
     **/
    public static function loadClass($file, $class, $dir = null) {
        self::loadFile($file, $dir, true);
        return new $class();
    }

    /**
     * function loadFile
     * param $file $dir $once
     * result: true or false
     * 
    **/
    public static function loadFile($file, $dir = null, $once = false) {
        $file .= '.php';
        if ($dir !== null) {
            $filename = $dir . '/' . $file;
            if (!file_exists($filename)) {
                throw new Web_Exception("file: ".$filename." is not exists\n");
            }
        }
        if ($once) {
            $result = include_once($filename);
        } else {
            $result = include($filename);
        }
        return $result;  
    }

    /**
     * db()
     * @param <string> $dbcfg
     * @param <type> $instance
     * @return db
    */
    public static function db($dbcfg, $instance = true) {
        if($instance && !empty(self::$_db[$dbcfg])){
            return self::$_db[$dbcfg];
        }else{
            $loadcfg = self::loadFile($dbcfg, CONF_DIR, true);
            if(!$loadcfg){
                throw new Web_Exception("db config $dbcfg not set.");
            }
            require_once LIB_DIR. '/Db.php';
            $db = new Web_Db($loadcfg);
            if ($instance) {
                self::$_db[$dbcfg] = $db;
            }
            return $db;
        }
    }


    /**
     * table()
     * @param <type> $table
     * @param <type> $db
     * @param <string> $dbcfg
     * @return Db_Table
     */
    public static function table($table, $dbcfg, $queryType = false) {
        if (null == $dbcfg || !is_string($dbcfg)) {
            return null;
        }
        $db = self::db($dbcfg, true);
        require_once LIB_DIR . '/Db_Table.php';
        if($queryType == false){
            return new Db_Table(array('name' => $table, 'db' => $db));
        }else{
            return new Db_Table(array('name' => $table, 'db' => $db, 'master'=>true));   
        }
        
    }



}
