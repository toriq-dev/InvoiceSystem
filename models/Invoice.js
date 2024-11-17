const db = require('../config/database');

// Get all invoices
const getInvoices = async () => {
  const [rows] = await db.query('SELECT * FROM invoices');
  return rows;
};

// Get a single invoice by ID
const getInvoiceById = async (id) => {
  const [rows] = await db.query(
    'SELECT * FROM invoices WHERE id = ?',
    [id]
  );
  return rows[0];
};

// Create a new invoice
const createInvoice = async (invoiceData, items) => {
  const connection = await db.getConnection();
  try {
    await connection.beginTransaction();

    // Insert invoice
    const [invoiceResult] = await connection.query(
      'INSERT INTO invoices (invoice_id, issue_date, due_date, subject, from_company, from_address, to_company, to_address, subtotal, tax, total, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        invoiceData.invoice_id,
        invoiceData.issue_date,
        invoiceData.due_date,
        invoiceData.subject,
        invoiceData.from_company,
        invoiceData.from_address,
        invoiceData.to_company,
        invoiceData.to_address,
        invoiceData.subtotal,
        invoiceData.tax,
        invoiceData.total,
        invoiceData.status,
      ]
    );

    const invoiceId = invoiceResult.insertId;

    // Insert items
    for (const item of items) {
      await connection.query(
        'INSERT INTO invoice_items (invoice_id, item_type, description, quantity, unit_price, amount) VALUES (?, ?, ?, ?, ?, ?)',
        [invoiceId, item.item_type, item.description, item.quantity, item.unit_price, item.amount]
      );
    }

    await connection.commit();
    return { id: invoiceId };
  } catch (error) {
    await connection.rollback();
    throw error;
  } finally {
    connection.release();
  }
};

// Update an invoice
const updateInvoice = async (id, updateData) => {
  const [result] = await db.query(
    'UPDATE invoices SET ? WHERE id = ?',
    [updateData, id]
  );
  return result;
};

// Delete an invoice
const deleteInvoice = async (id) => {
  const [result] = await db.query('DELETE FROM invoices WHERE id = ?', [id]);
  return result;
};

module.exports = {
  getInvoices,
  getInvoiceById,
  createInvoice,
  updateInvoice,
  deleteInvoice,
};

