package com.infol.nztest.controller;

import java.text.SimpleDateFormat;
import java.util.Date;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import  org.springframework.scheduling.annotation.Scheduled;
import  org.springframework.stereotype.Component;


@Component
public class ScheduledTasks {
    private static final Logger logger = LoggerFactory.getLogger(ScheduledTasks.class);
    private  static final SimpleDateFormat dataFromat = new SimpleDateFormat("HH:mm:ss");

/*    @Scheduled(cron="0 0/1 * * * ?")
    public void reportCurrent(){
        CardReaderController cardReaderController = new CardReaderController();
        //String result = cardReaderController.responseSeals();
        logger.info("现在时间：{}",dataFromat.format(new Date()));
    }*/

}
