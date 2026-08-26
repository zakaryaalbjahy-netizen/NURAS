const express = require("express");
const { Pool } = require("pg");
const app = express();
app.use(express.json());
const port = process.env.PORT || 10000;
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false
});
app.get("/", (req,res)=>res.json({name:"NURAS",version:"1.0.0",status:"running"}));
app.get("/api/health", async (req,res)=>{
  try { await pool.query("SELECT 1"); res.json({status:"ok",database:"connected"}); }
  catch { res.status(503).json({status:"error",database:"unavailable"}); }
});
app.get("/api/v1/organizations", async (req,res)=>{
  try { const r=await pool.query("SELECT id,name,type,created_at FROM organizations ORDER BY id"); res.json(r.rows); }
  catch { res.status(500).json({error:"Database query failed"}); }
});
app.listen(port,()=>console.log(`NURAS running on port ${port}`));
