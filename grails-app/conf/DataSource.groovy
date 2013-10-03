dataSource {
    pooled = true
    driverClassName = "com.microsoft.sqlserver.jdbc.SQLServerDriver"
    username = "sa"
    password = "xx"
	dialect = "org.hibernate.dialect.SQLServerDialect"
}
hibernate {
    cache.use_second_level_cache = true
    cache.use_query_cache = false
    cache.region.factory_class = 'net.sf.ehcache.hibernate.EhCacheRegionFactory'
}
// environment specific settings
environments {
    development {
        dataSource {
            dbCreate = "create-drop" // one of 'create', 'create-drop', 'update', 'validate', ''
            url = "jdbc:sqlserver://192.168.3.107:1433;databaseName=test_dev"
        }
    }
    test {
        dataSource {
            dbCreate = "update"
            url = "jdbc:sqlserver://192.168.3.107:1433;databaseName=test_dev"
        }
    }
    production {
        dataSource {
            dbCreate = "update"
            url = "jdbc:sqlserver://192.168.3.107:1433;databaseName=test_dev"
            pooled = true
            properties {
               maxActive = -1
               minEvictableIdleTimeMillis=1800000
               timeBetweenEvictionRunsMillis=1800000
               numTestsPerEvictionRun=3
               testOnBorrow=true
               testWhileIdle=true
               testOnReturn=true
               validationQuery="SELECT 1"
            }
        }
    }
}
