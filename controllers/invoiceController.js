const invoiceModel = require('../models/Invoice');

// Get all invoices
const getInvoices = async (req, res) => {
  try {
    const invoices = await invoiceModel.getInvoices();
    res.status(200).json(invoices);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get invoice by ID
const getInvoiceById = async (req, res) => {
  try {
    const invoice = await invoiceModel.getInvoiceById(req.params.id);
    if (!invoice) return res.status(404).json({ message: 'Invoice not found' });
    res.status(200).json(invoice);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Create new invoice
const createInvoice = async (req, res) => {
  try {
    const { invoiceData, items } = req.body;
    const result = await invoiceModel.createInvoice(invoiceData, items);
    res.status(201).json(result);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Update invoice
const updateInvoice = async (req, res) => {
  try {
    const result = await invoiceModel.updateInvoice(req.params.id, req.body);
    if (result.affectedRows === 0)
      return res.status(404).json({ message: 'Invoice not found' });
    res.status(200).json({ message: 'Invoice updated successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete invoice
const deleteInvoice = async (req, res) => {
  try {
    const result = await invoiceModel.deleteInvoice(req.params.id);
    if (result.affectedRows === 0)
      return res.status(404).json({ message: 'Invoice not found' });
    res.status(200).json({ message: 'Invoice deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = {
  getInvoices,
  getInvoiceById,
  createInvoice,
  updateInvoice,
  deleteInvoice,
};
