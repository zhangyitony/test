package cn.gov.xaczj;

import org.hibernate.*;
import org.hibernate.mapping.PersistentClass;
import org.hibernate.tool.hbm2ddl.SchemaUpdate;
import org.hibernate.cfg.Configuration;

import cn.gov.xaczj.domain.Table;

public class HibernateUtil {

	private static HibernateUtil instance;
	private Configuration configuration;
	private SessionFactory sessionFactory;
	private Session session;

	public synchronized static HibernateUtil getInstance() {
		if (instance == null) {
			instance = new HibernateUtil();
		}
		return instance;
	}

	public synchronized void setSessionFactory(SessionFactory sf) {
		sessionFactory = sf;

	}

	private synchronized SessionFactory getSessionFactory() {
		if (sessionFactory == null) {
			sessionFactory = getConfiguration().buildSessionFactory();
		}
		return sessionFactory;
	}

	public synchronized Session getCurrentSession() {
		 if (session == null) {
		session = getSessionFactory().openSession();
		session.setFlushMode(FlushMode.COMMIT);
		System.out.println("session opened.");
		 }
		return session;
	}

	public synchronized Configuration getConfiguration() {
		if (configuration == null) {
			System.out.print("configuring Hibernate ... ");
			try {
				configuration = new Configuration().configure();
				configuration.addClass(Table.class);
				System.out.println("ok");
			} catch (HibernateException e) {
				System.out.println("failure");
				e.printStackTrace();
			}
		}
		return configuration;
	}

	public void reset() {
		Session session = getCurrentSession();
		if (session != null) {
			session.flush();
			if (session.isOpen()) {
				System.out.print("closing session ... ");
				session.close();
				System.out.println("ok");
			}
		}
		SessionFactory sf = getSessionFactory();
		if (sf != null) {
			System.out.print("closing session factory ... ");
			sf.close();
			System.out.println("ok");
		}
		this.configuration = null;
		this.sessionFactory = null;
		this.session = null;
	}

	public PersistentClass getClassMapping(Class entityClass) {
		// Configuration configuration = getConfiguration();
		// configuration=new Configuration().configure();
		// configuration.addClass(Contact.class);
		// System.out.println(getConfiguration().getClassMapping(entityClass.getName()));
		return getConfiguration().getClassMapping(entityClass.getName());

	}

	public PersistentClass getClassMapping(String entityName) {

		return getConfiguration().getClassMapping(entityName);
	}
}