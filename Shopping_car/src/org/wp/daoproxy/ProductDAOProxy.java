package org.wp.daoproxy;

import java.util.List;
import java.util.Set;
import java.util.concurrent.CountDownLatch;

import org.wp.dao.IProductDAO;
import org.wp.dao.impl.ProductDAOimpl;
import org.wp.dbc.DatabaseConnection;
import org.wp.vo.Product;

import jdk.nashorn.internal.ir.Flags;
import sun.util.logging.resources.logging;

public class ProductDAOProxy implements IProductDAO {
	private DatabaseConnection dbc = null;
	private IProductDAO dao = null;
	long count = 0;
	public ProductDAOProxy() {
		this.dbc = new DatabaseConnection();
		this.dao = new ProductDAOimpl(this.dbc.getConnection());
	}
	@Override
	public boolean doCreate(Product vo) throws Exception {
		boolean flag = false;
		try {
			flag = this.dao.doCreate(vo);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return flag;
	}

	@Override
	public boolean doUpdate(Product vo) throws Exception {
		boolean flag = false;
		try {
			flag = this.dao.doUpdate(vo);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return flag;
	}

	@Override
	public boolean doRemove(Integer id) throws Exception {
		boolean flag = false;
		try {
			flag = this.dao.doRemove(id);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return flag;
	}

	@Override
	public Product findById(Integer id) throws Exception {
		Product pro = null;
		try {
			pro = this.dao.findById(id);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return pro;
	}

	@Override
	public List<Product> findAll(String keyword) throws Exception {
		List<Product> all = null;
		try {
			all = this.dao.findAll(keyword);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return all;
	}

	@Override
	public List<Product> findAll(String keyword, int intcurrentPage, int lineSize) throws Exception {
		List<Product> all = null;
		try {
			all = this.dao.findAll(keyword, intcurrentPage, lineSize);
			this.count = this.dao.getAllCount(keyword);			//������������������������������������������
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return all;
	}

	@Override
	public long getAllCount(String keyword) throws Exception {
		return this.count;
	}

	@Override
	public List<Product> findAll(Set<Integer> key) throws Exception {
		List<Product> all = null;
		try {
			all = this.dao.findAll(key);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
		return all ;
	}

	@Override
	public void doUpdateCount(Integer id) throws Exception {
		try {
			this.dao.doUpdateCount(id);
		}catch(Exception e) {
			throw e;
		}finally {
			this.dbc.Close();
		}
	}

}
