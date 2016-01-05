<?php
/*************************************************************************************/
/*      This file is part of the Thelia package.                                     */
/*                                                                                   */
/*      Copyright (c) OpenStudio                                                     */
/*      email : dev@thelia.net                                                       */
/*      web : http://www.thelia.net                                                  */
/*                                                                                   */
/*      For the full copyright and license information, please view the LICENSE.txt  */
/*      file that was distributed with this source code.                             */
/*************************************************************************************/

namespace DealerContent;

use DealerContent\Model\DealerContentQuery;
use Propel\Runtime\Connection\ConnectionInterface;
use Thelia\Install\Database;
use Thelia\Module\BaseModule;

class DealerContent extends BaseModule
{
    /** @var string */
    const DOMAIN_NAME = 'dealercontent';

    public function postActivation(ConnectionInterface $con = null)
    {
        try {
            DealerContentQuery::create()->findOne();
        } catch (\Exception $e) {
            $database = new Database($con);
            $database->insertSql(null, [__DIR__ . "/Config/thelia.sql"]);
        }
    }
}
