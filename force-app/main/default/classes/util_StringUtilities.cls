public class util_StringUtilities{
    /*
    String Utilities - toRightSize 10 lead fields - Bug229777

    MODIFICATION HISTORY
    07-05-2021 JPR - Created toRightCase for list of Fields to "RightSize"
    08-02-2021 JPR - modified to Trim space & account for Mc, Mac, Van, Von (Eventually convert to Custom 
    */

    public static string toRightCase(string inString){
        system.debug('util_StringUtilities.toRightCase...');
        if(inString == Null) {return inString;}
        if(inString.length()==0) {return inString;}
        
        List<string> words = inString.normalizeSpace().split(' ');
        system.debug ('words= '+words);
        set<string> articlesToLeave = new set<string>{'a','an','and','at','but','for','PO','BOX','IV','II','III','in', 'nor', 'of', 'or','the','to','with','de','la','the','van','von','mackinaw','MD-DDS','DMD','DMD-MD'};
        Map<String, String> mArticlesToConvert = new Map<String, String>{
            'mc'    =>  'Mc',
            'von'   =>  'Von',
            'van'   =>  'Van',
            'mac'   =>  'Mac',
            'MACON' =>  'Macon',
            'suite' =>  'Ste',
            'SUITE' =>  'Ste',
            'obrien'=>  'O\'Brien'
        };
            
            if(words.contains('o')){
                system.debug( 'Letter o pos:' + words.indexOf('o') + ' ' + words[words.indexOf('o') + 1 ]);
                String afterO = words.remove(words.indexOf('o') + 1 ) ;
                words.set(words.indexOf('o') , 'o' + '\'' + afterO) ;
                //words.remove(words.indexOf('o') ) ;
                //words.add( 'o' + '\'' + afterO);
            }
            if(words.contains('O')){
                system.debug( 'Letter O pos:' + words.indexOf('O') + ' ' + words[words.indexOf('o') + 1 ]);
                String afterO = words.remove(words.indexOf('O') + 1 ) ;
                words.set(words.indexOf('O') , 'o' + '\'' + afterO) ;
            }


        string outString= '';
        for (string word :words) {
            system.debug ('word= '+word) ;
            if(articlesToLeave.contains(word)) {
                outString+=word + ' ';
                System.debug ('Oustring='+outString);
                continue;
            }
            word = word.toLowerCase();
            if(mArticlesToConvert.containsKey(word) ){
                outstring+=mArticlesToConvert.get(word) + ' ';
                System.debug('suuuuite' + word);
                continue;
            }
            //word = word.toLowerCase();
            
            if (word.containsAny('-')){
                List<String>splitwords = word.split('-') ;
                System.Debug(splitwords);
                //System.Debug(splitwords[0]. capitalize()+' '+splitwords[1].capitalize());
                word = splitwords[0]+'-'+ splitwords[1].capitalize();
            }
            if(word.containsAny('\'')){
                List<String>splitwords= word.split('\'');
                //System.Debug (splitwords);
                System.Debug(splitwords[0].capitalize()+'\''+splitwords[1].capitalize());
                outString += splitwords[0].capitalize() +'\''+ splitwords[1].capitalize() + ' ';
                continue;
            }

            if(articlesToLeave.contains(word) ){
                outString += word + ' ';
                continue;
            }

            List<String> match2 = new List<String>{'mc', 'mr', 've'};
            if(match2.contains(word.left(2))){
                 System.debug('word.match2 ' + word.left(2));
                outString += word.left (2).capitalize() +word.right (word.length()-2).capitalize()+' ';
                continue;
            }
            List<String> match3 = new List<String>{'mac', 'von', 'van'};
            if(match3.contains(word.left(3))){
                 System.debug('word.match3 ' + word.left(3));
                outString += word.left (3).capitalize() +word.right (word.length()-3).capitalize()+' ';
                continue;
            }

            /*if(mArticlesToConvert.containsKey(word.left(2))) {
                System.debug('WORD CAP='+word);
                System.debug('word.left ' + word.left(2));
                outString+=mArticlesToConvert.get(word.left(2)) +word.right (word.length()-2).capitalize()+' ';
                continue;
            }
            if(mArticlesToConvert.containsKey(word.left(3))) {
                System.debug ('WORD CAP='+word) ;
                System.debug('word.left ' + word.left(3) + mArticlesToConvert.get(word.left (3)) + word.right (word.length()-3));
                outString+=mArticlesToConvert.get(word.left (3)) +word.right (word.length()-3).capitalize()+' ';
                continue;
            }*/
            
            outString +=word.capitalize()+' ';
        }
        system.debug ('outString= ' +outString);
        return outString.trim();
    }
}